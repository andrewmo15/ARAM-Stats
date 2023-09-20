//
//  ContentView.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/15/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var api = APIController()
    @State var viewDidLoad = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(api.games) { game in
                        NavigationLink(destination: GameDetailView(game: game)) {
                            GameOverviewCard(game: game)
                        }
                    }
                }
            }
            .onAppear {
                if !viewDidLoad {
                    api.fetchGames(username: "Spaniel2611")
                }
                viewDidLoad = true
            }
        }.navigationTitle("Games")
    }
}
