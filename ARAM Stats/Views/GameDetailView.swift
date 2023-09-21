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
        VStack {
            HStack {
                Text("\(game.team1.win ? "Win" : "Lose")")
                    .frame(maxWidth: .infinity, alignment: .bottomLeading).padding(.leading, 15)
                    .font(.system(size: 35))
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(.white)
                Text("\(self.getTime(seconds: game.gameInfo.gameDuration)) | \(game.gameInfo.daysElapsed) days ago")
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing).padding(.trailing, 15)
                    .font(.system(size: 12))
                    .lineLimit(1)
                    .foregroundColor(.white)
            }.frame(height: 50).background(game.userGameDetails.win ? .blue : .red)
            
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Text("\(game.team1.win ? "Win" : "Lose")   \(game.team1.kills) / \(game.team1.deaths) / \(game.team1.assists)")
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 15)
                        .bold()
                        .foregroundColor(game.userGameDetails.win ? .blue : .red)
                    VStack(alignment: .trailing) {
                        Text("Turrets: \(game.team2.turretsLost)")
                            .font(.system(size: 9))
                            .bold()
                            .foregroundColor(game.userGameDetails.win ? .blue : .red)
                        Text("Inhibitors: \(game.team2.inhibitorsLost)")
                            .font(.system(size: 9))
                            .bold()
                            .foregroundColor(game.userGameDetails.win ? .blue : .red)
                    }.frame(maxWidth: .infinity, alignment: .bottomTrailing).padding(.trailing, 15)
                }
                VStack(spacing: -0.25) {
                    ForEach(game.team1.participants) { user in
                        NavigationLink(destination: GameOverviewView(username: user.summonerName, region: region)) {
                            UserDetailView(user: user, maxDamage: game.team1.maxDamage).border(Color(UIColor.lightGray), width: 0.5)
                        }
                    }
                }
                
                HStack {
                    Text("\(game.team2.win ? "Win" : "Lose")   \(game.team2.kills) / \(game.team2.deaths) / \(game.team2.assists)").bold().foregroundColor(game.userGameDetails.win ? .red : .blue)
                        .frame(maxWidth: .infinity, alignment: .bottomLeading).padding(.leading, 15)
                        .bold()
                        .foregroundColor(game.userGameDetails.win ? .red : .blue)
                    VStack(alignment: .trailing) {
                        Text("Turrets: \(game.team1.turretsLost)")
                            .frame(maxWidth: .infinity, alignment: .bottomTrailing).padding(.trailing, 15)
                            .font(.system(size: 9))
                            .bold()
                            .foregroundColor(game.userGameDetails.win ? .red : .blue)
                        Text("Inhibitors: \(game.team1.inhibitorsLost)")
                            .frame(maxWidth: .infinity, alignment: .bottomTrailing).padding(.trailing, 15)
                            .font(.system(size: 9))
                            .bold()
                            .foregroundColor(game.userGameDetails.win ? .red : .blue)
                    }
                }.padding(.top, 20)
                VStack(spacing: -0.25) {
                    ForEach(game.team2.participants) { user in
                        NavigationLink(destination: GameOverviewView(username: user.summonerName, region: region)) {
                            UserDetailView(user: user, maxDamage: game.team2.maxDamage).border(Color(UIColor.lightGray), width: 0.5)
                        }
                    }
                }
            }
        }
    }
    
    private func getTime(seconds: Int) -> String {
        var sec = "\(seconds % 60)"
        if sec.count == 1 {
            sec = "0" + sec
        }
        return "\(seconds / 60):\(sec)"
    }
}
