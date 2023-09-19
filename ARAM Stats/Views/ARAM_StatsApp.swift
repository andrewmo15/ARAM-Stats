//
//  ARAM_StatsApp.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/15/23.
//

import SwiftUI

@main
struct ARAM_StatsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
