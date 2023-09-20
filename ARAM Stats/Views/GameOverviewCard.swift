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
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 120)
            HStack(alignment: .center, spacing: 35) {
                VStack(alignment: .center) {
                    Text("\(game.userGameDetails.win ? "W" : "L")").foregroundColor(.white).font(.system(size: 15))
                    Text("\(game.gameInfo.gameDuration)").foregroundColor(.white).font(.system(size: 15))
                }.frame(width: 30, height: 150)
                VStack(alignment: .leading) {
                    HStack {
                        Image(game.userGameDetails.championName).resizable().frame(width: 50, height: 50)
                        VStack {
                            Image(game.userGameDetails.summoner1Id).resizable().frame(width: 22, height: 22)
                            Image(game.userGameDetails.summoner2Id).resizable().frame(width: 22, height: 22)
                        }
                        VStack {
                            Image(game.userGameDetails.rune1).resizable().frame(width: 22, height: 22)
                            Image(game.userGameDetails.rune2).resizable().frame(width: 22, height: 22)
                        }
                        Text("\(game.userGameDetails.kills)/\(game.userGameDetails.deaths)/\(game.userGameDetails.assists)").foregroundColor(.white).frame(width: 80, height: 40).font(.system(size: 20))
                    }
                    HStack {
                        Image(game.userGameDetails.item0).resizable().frame(width: 22, height: 22)
                        Image(game.userGameDetails.item1).resizable().frame(width: 22, height: 22)
                        Image(game.userGameDetails.item2).resizable().frame(width: 22, height: 22)
                        Image(game.userGameDetails.item3).resizable().frame(width: 22, height: 22)
                        Image(game.userGameDetails.item4).resizable().frame(width: 22, height: 22)
                        Image(game.userGameDetails.item5).resizable().frame(width: 22, height: 22)
                        Image(game.userGameDetails.item6).resizable().frame(width: 22, height: 22)
                    }
                }
                Text("\(game.gameInfo.daysElapsed) days ago").foregroundColor(.white).font(.system(size: 15))
            }
        }
    }
}
