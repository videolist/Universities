//
//  UniversitiesDataSource.swift
//  Universities
//
//  Created by Vadim on 4/6/17.
//  Copyright © 2017 Digital Prunes. All rights reserved.
//

import UIKit
import RealmSwift

class UniversitiesDataSource: RealmDataSource<RealmUniversity, UniversityTableViewCell> {
    
    override var sortDescriptors: [SortDescriptor]? {
        let sortDescriptor = SortDescriptor(keyPath: "name", ascending: true)
        return [sortDescriptor]
    }

}
