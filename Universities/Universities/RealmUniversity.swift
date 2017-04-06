//
//  RealmUniversity.swift
//
//  Created by Vadim on 10/7/16.
//

import RealmSwift

class RealmUniversity: RealmObject, AllObjects {
    dynamic var name: String?
    dynamic var country: String?
    dynamic var webPage: String?
    dynamic var countryCode: String?
    
    var domain: String? {
        // Domain is used as the object unique ID in the DB
        return id
    }
    
    static func update(from someObject: Any) -> RealmUniversity? {
        if let json = someObject as? [String: String] {
            if let domain = json[UniversitiesAPI.fields.domain.rawValue] {
                return self.update(from: json, with: domain)
            }
            return nil
        }
        return nil
    }
    
    override func update(from someObject: Any) {
        guard let json = someObject as? [String: String] else {
            return
        }
        
        for (field, value) in json {
            if let field = UniversitiesAPI.fields(rawValue: field) {
                switch field {
                case .name:
                    name = value
                case .country:
                    country = value
                case .countryCode:
                    countryCode = value
                case .webPage:
                    webPage = value
                default:
                    break
                }
            }
        }
    }

    static func allObjects() -> Results<RealmUniversity> {
        return allObjects(type: self)
    }
    
}
