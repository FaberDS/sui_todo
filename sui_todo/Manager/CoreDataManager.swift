//
//  CoreDataManager.swift
//  sui_todo
//
//  Created by Denis Schüle on 27.10.21.
//

import CoreData
import Foundation

class CoreDataManager {
    // Singleton
    public static let shared = CoreDataManager(inMemory: false)
    
    static var preview: CoreDataManager = {
       let manager = CoreDataManager(inMemory: true)
        let viewContext = manager.persistentContainer.viewContext
        
        
        for _ in 0..<5 {
            let todo = Todo(context: viewContext)
            todo.title = "Task \((0...9).randomElement()!)"
            todo.id = UUID()
            todo.timestamp = Date()
            todo.priority = (0...2).randomElement()!
        }
        try? viewContext.save()

        return manager
    }()
    let persistentContainer : NSPersistentContainer

    private init(inMemory : Bool){
        persistentContainer = NSPersistentContainer(name: "SwiftUI_CoreData_Todo")

        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL (fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { (_, error )in
            if let error = error {
                fatalError("Thumb error need to be handled")
            }
        }
        
    }
    
   
}
