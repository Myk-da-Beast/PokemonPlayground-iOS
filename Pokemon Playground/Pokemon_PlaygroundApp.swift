//
//  Pokemon_PlaygroundApp.swift
//  Pokemon Playground
//
//  Created by Michael Vance on 11/7/20.
//

import SwiftUI

@main
struct Pokemon_PlaygroundApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
