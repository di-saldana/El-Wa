//
//  el_waApp.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 11/30/24.
//

import SwiftUI
import SwiftData

@main
struct el_waApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            StartView()
        }
        .modelContainer(sharedModelContainer)
    }
}
