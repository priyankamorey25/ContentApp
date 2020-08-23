//
//  ContentDataManager.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 23/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import Foundation
import CoreData

class ContentDataManager: CoreDataManager {
    
    func fetchAllContentList() -> Array<Content>?? {
        let fetchReq: NSFetchRequest<Content> = Content.fetchRequest()
        do {
            let objects = try context.fetch(fetchReq)
            return objects
        } catch {
            print("Fetch Failed")
        }
        return nil
    }
    
    @discardableResult func addItem(id:String,date:String,data:String,type:String) -> Content {
      //  ContentDataManager.deleteAll()
        let entity = Content(context: context)
      //  for content in contentList{
        entity.id = id
        entity.date = date
        entity.data = data
        entity.type = type
            CoreDataStack.shared.saveContext()
            
       // }
        return entity
    }
    
    func delete(object: Content) -> Bool {
        context.delete(object)
        return true
    }
    @discardableResult  func deleteAll() -> Bool {
        // Create Fetch Request
        let fetchReq: NSFetchRequest<Content> = Content.fetchRequest()

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReq as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch {
            return false
            print(error.localizedDescription)
        }
        return true
    }
    
}
