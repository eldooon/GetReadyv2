//
//  DataStore.swift
//  GetReady
//
//  Created by Eldon Chan on 9/1/16.
//  Copyright © 2016 Eldon. All rights reserved.
//

import UIKit
import CoreData

class DataStore {
    
    static let sharedDataStore = DataStore()
    var currentInfo = UserInfo()
    var location = [NSManagedObject]()
}
