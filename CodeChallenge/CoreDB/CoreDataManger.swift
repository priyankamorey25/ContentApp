//
//  CoreDataManger.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 23/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    let context = CoreDataStack.shared.persistentContainer.viewContext
    let managedObjectModel = CoreDataStack.shared.persistentContainer.managedObjectModel

    init() {
        
    }
}
