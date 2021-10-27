//
//  sui_todoApp.swift
//  sui_todo
//
//  Created by Denis Schüle on 27.10.21.
//

import SwiftUI

@main
struct sui_todoApp: App {
    let manager = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.persistentContainer.viewContext)
        }
    }
}
