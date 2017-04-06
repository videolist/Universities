//
//  RealmObject.swift
//
//  Created by Vadim on 7/11/16.
//

import RealmSwift

let currentVersion:UInt64 = 1


protocol AllObjects {
    associatedtype T :RealmObject
    static func allObjects() -> Results<T>
}

class RealmObject: Object {
    
    dynamic var id: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String?) {
        self.init()
        self.id = id
    }
    
    static func update(from someObject: Any, with id: String) -> Self {
        return update(self, from: someObject, with: id)
    }
    
    static func update<T: RealmObject>(_ type: T.Type, from someObject: Any, with id: String) -> T {
        var object: T! = T.object(for: id)
        self.write {
            if object == nil {
                object = T()
                object.id = id
                let _ = object.persist()
            }
            object.update(from: someObject)
        }
        return object
    }
    
    func update(from someObject: Any) {
        assert(false, "This method has to be implemented by subclass!")
    }
    

    func persist() -> Self {
        let realm = try! Realm()
        Realm.write {
            realm.add(self, update:true)
        }
        return self;
    }
    
    func delete() {
        let realm = try! Realm()
        Realm.write {
            realm.delete(self)
        }
    }
    
    static func object(for objectId: String?) -> Self? {
        if objectId == nil {
            return nil
        }
        let realm = try! Realm()
        return realm.object(ofType: self, forPrimaryKey: objectId)
    }
    
    static func write(_ block:()->Void) {
        Realm.write(block)
    }

    func write(_ block:()->Void) {
        Realm.write(block)
    }
    
    static func deleteAll() {
        let realm = try! Realm()
        Realm.write {
            realm.delete(realm.objects(self))
        }
    }

    static func allObjects<T: RealmObject>(type: T.Type) -> Results<T> {
        let realm = try! Realm()
        return realm.objects(T.self)
    }

}

extension Realm {
    static func migrateIfNeeded() -> Void {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: currentVersion,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < currentVersion) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    static func write(_ block:()->Void) {
        let realm = try! Realm()
        if (realm.isInWriteTransaction) {
            block()
        } else {
            try! realm.write(block)
        }
    }
    
    static func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}

