//
//  SwiftUITaskAppApp.swift
//  SwiftUITaskApp
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI

@main
struct SwiftUITaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
