//
//  GameOverviewCard.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import SwiftUI

struct GameOverviewCard: View {
    
    @State var game: Game
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 200)
            HStack {
                VStack(alignment: .leading) {
                    Text("\(game.userGameDetails.win ? "Win" : "Loss")")
                    Text("\(game.gameInfo.gameDuration)")
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(game.userGameDetails.championName)")
                        VStack {
                            Text("\(game.userGameDetails.summoner1Id)")
                            Text("\(game.userGameDetails.summoner2Id)")
                        }
                        VStack {
                            Text("\(game.userGameDetails.rune1)")
                            Text("\(game.userGameDetails.rune2)")
                        }
                        Text("\(game.userGameDetails.kills)/\(game.userGameDetails.deaths)/\(game.userGameDetails.assists)")
                    }
                    HStack {
                        Text("\(game.userGameDetails.item0)")
                        Text("\(game.userGameDetails.item1)")
                        Text("\(game.userGameDetails.item2)")
                        Text("\(game.userGameDetails.item3)")
                        Text("\(game.userGameDetails.item4)")
                        Text("\(game.userGameDetails.item5)")
                        Text("\(game.userGameDetails.item6)")
                    }
                }
                Text("\(game.gameInfo.daysElapsed) days ago")
            }
        }
    }
}
