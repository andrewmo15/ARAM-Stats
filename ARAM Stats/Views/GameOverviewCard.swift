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
                .fill(Color.white)
                .frame(height: 100)
            HStack {
                VStack(alignment: .center) {
                    Text("\(game.userGameDetails.win ? "W" : "L")").foregroundColor(.white).font(.system(size: 17)).underline()
                    Text("\(self.getTime(seconds: game.gameInfo.gameDuration))").foregroundColor(.white).font(.system(size: 12))
                }.frame(width: 35, height: 100, alignment: .leading).background(game.userGameDetails.win ? Color.blue : Color.red)
                
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
                        Text("\(game.userGameDetails.kills) / \(game.userGameDetails.deaths) / \(game.userGameDetails.assists)").foregroundColor(.black).frame(width: 80, height: 40).font(.system(size: 13)).bold()
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
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(game.gameInfo.daysElapsed) days ago").foregroundColor(.black).font(.system(size: 12)).frame(maxWidth: .infinity, alignment: .trailing)
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
