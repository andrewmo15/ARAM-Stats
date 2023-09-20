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
                    Text("\(game.userGameDetails.win ? "Win" : "Loss")").foregroundColor(.white)
                    Text("\(game.gameInfo.gameDuration)").foregroundColor(.white)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Image(game.userGameDetails.championName).resizable().frame(width: 32.0, height: 32.0)
                        VStack {
                            Image(game.userGameDetails.summoner1Id).resizable().frame(width: 32.0, height: 32.0)
                            Image(game.userGameDetails.summoner2Id).resizable().frame(width: 32.0, height: 32.0)
                        }
                        VStack {
                            Image(game.userGameDetails.rune1).resizable().frame(width: 32.0, height: 32.0)
                            Image(game.userGameDetails.rune2).resizable().frame(width: 32.0, height: 32.0)
                        }
                        Text("\(game.userGameDetails.kills)/\(game.userGameDetails.deaths)/\(game.userGameDetails.assists)").foregroundColor(.white)
                    }
                    HStack {
                        Image(game.userGameDetails.item0).resizable().frame(width: 32.0, height: 32.0)
                        Image(game.userGameDetails.item1).resizable().frame(width: 32.0, height: 32.0)
                        Image(game.userGameDetails.item2).resizable().frame(width: 32.0, height: 32.0)
                        Image(game.userGameDetails.item3).resizable().frame(width: 32.0, height: 32.0)
                        Image(game.userGameDetails.item4).resizable().frame(width: 32.0, height: 32.0)
                        Image(game.userGameDetails.item5).resizable().frame(width: 32.0, height: 32.0)
                        Image(game.userGameDetails.item6).resizable().frame(width: 32.0, height: 32.0)
                    }
                }
                Text("\(game.gameInfo.daysElapsed) days ago").foregroundColor(.white)
            }
        }
    }
}
