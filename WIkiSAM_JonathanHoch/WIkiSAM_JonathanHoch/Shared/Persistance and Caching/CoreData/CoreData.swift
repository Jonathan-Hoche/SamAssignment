//
//  CoreData.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 15/05/2021.
//

import Foundation
import CoreData

struct CoreData {
    
    private init() {}
    
    static var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        let container = NSPersistentContainer(name: "WIkiSAM_JonathanHoch")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error  {
                print(error)
            }
        })
        
        // print(persistentContainerPublic.persistentStoreDescriptions) // this prints the path to the sqlite file
        return container
    }()
}

extension CoreData {

    static func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

