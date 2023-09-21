//
//  ARAM_StatsApp.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/15/23.
//

import SwiftUI

@main
struct ARAM_StatsApp: App {
    
    @StateObject private var dataController = SearchHistoryController()

    var body: some Scene {
        WindowGroup {
            ContentView(dataControllerError: dataController.error)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
