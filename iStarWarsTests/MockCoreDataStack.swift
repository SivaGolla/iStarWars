//
//  MockCoreDataStack.swift
//  iStarWarsTests
//
//  Created by Venkata Sivannarayana Golla on 18/05/23.
//

import CoreData
import Foundation
@testable import iStarWarsMock

class MockCoreDataStack: CoreDataStack {
    
    override init() {
        super.init()
        persistentContainer = mockContainer
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Planets", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            precondition(storeDescription.type == NSInMemoryStoreType)
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public override func saveContext () {
        do {
            try mockContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error.localizedDescription)")
        }
    }
    
    func clearAllPlanetsInDatabase() {
        
//        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItem")
//        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
//        for case let obj as NSManagedObject in objs {
//            mockPersistantContainer.viewContext.delete(obj)
//        }
//        
//        try! mockPersistantContainer.viewContext.save()
//        
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        batchDeleteRequest.resultType = .resultTypeCount
//        do {
//            let count = try mockContainer.viewContext.execute(batchDeleteRequest)
//            debugPrint("Deleted items count: \(count)")
//        } catch {
//            debugPrint("Detele all Planet data - error :", error)
//        }
    }
}
