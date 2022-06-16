//
//  progressApp.swift
//  progress
//
//  Created by Moriz Buehler on 16.06.22.
//

import SwiftUI

@main
struct progressApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
