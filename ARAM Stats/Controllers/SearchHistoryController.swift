//
//  SearchHistoryController.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/20/23.
//

import Foundation
import CoreData

class SearchHistoryController: ObservableObject {
    
    let container = NSPersistentContainer(name: "search-history")
    var error: String?
    
    init() {
        container.loadPersistentStores { description, error in
            if let _ = error {
                self.error = "Could not load search history"
            }
        }
    }
}
