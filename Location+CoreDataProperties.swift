//
//  Location+CoreDataProperties.swift
//  GetReadyv2
//
//  Created by Eldon Chan on 9/12/16.
//  Copyright © 2016 Eldon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var city: String?
    @NSManaged var state: String?

}
