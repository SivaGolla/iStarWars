//
//  CoreDataStack.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 15/05/23.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static var shared = CoreDataStack()
    
    private init() { }
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "iStarWars")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
