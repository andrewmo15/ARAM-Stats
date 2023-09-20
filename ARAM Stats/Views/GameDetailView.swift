//
//  GameDetailView.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import SwiftUI

struct GameDetailView: View {
    
    @State var game: Game
    @State var region: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                Text("\(game.team1.win ? "Win" : "Lose")")
                Text("\(game.team1.kills)/\(game.team1.deaths)/\(game.team1.assists)")
                Text("\(game.team1.turretsLost), \(game.team1.inhibitorsLost)")
            }
            ForEach(game.team1.participants) { user in
                NavigationLink(destination: GameOverviewView(username: user.summonerName, region: region)) {
                    UserDetailView(user: user)
                }
            }
            
            HStack {
                Text("\(game.team2.win ? "Win" : "Lose")")
                Text("\(game.team2.kills)/\(game.team2.deaths)/\(game.team2.assists)")
                Text("\(game.team2.turretsLost), \(game.team2.inhibitorsLost)")
            }
            ForEach(game.team2.participants) { user in
                NavigationLink(destination: GameOverviewView(username: user.summonerName, region: region)) {
                    UserDetailView(user: user)
                }
            }
        }
    }
}
