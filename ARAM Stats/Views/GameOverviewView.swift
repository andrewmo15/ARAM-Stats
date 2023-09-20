//
//  GameOverviewView.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/19/23.
//

import SwiftUI

struct GameOverviewView: View {
    
    @State var username: String
    @State var region: String
    @StateObject private var api = APIController()
    @State private var viewDidLoad = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(api.games) { game in
                    NavigationLink(destination: GameDetailView(game: game, region: region)) {
                        GameOverviewCard(game: game)
                    }
                }
            }
        }
        .onAppear {
            if !viewDidLoad {
                api.fetchGames(username: username, region: region)
            }
            viewDidLoad = true
        }
    }
}
