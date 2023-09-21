//
//  StatsCards.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/20/23.
//

import SwiftUI

struct StatsCards: View {
    
    @State var stats: Stats
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                VStack {
                    Text("Win Rate (past 20 games)").foregroundColor(.black).bold().font(.system(size: 10))
                    Gauge(value: (stats.wr / 100.0)) {
                        EmptyView()
                    } currentValueLabel: {
                        Text("\(String(format: "%.2f", stats.wr))%").foregroundColor(.black)
                    }.gaugeStyle(.accessoryCircularCapacity).tint(.blue)
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
                VStack {
                    Text("KDA Stats").foregroundColor(.black).underline().bold().font(.system(size: 10))
                    Text("\(stats.simplifiedKDA)").foregroundColor(.black).font(.system(size: 10))
                    Text("KDA: \(stats.averageKDA)").foregroundColor(.black).font(.system(size: 10))
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
                VStack {
                    Text("Longest Game").foregroundColor(.black).underline().bold().font(.system(size: 10))
                    Text("Game Duration \(self.getTime(seconds: stats.longestGame.gameInfo.gameDuration))").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills: \(stats.longestGame.team1.kills + stats.longestGame.team2.kills)").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills Per Min: \(self.getKPM(game: stats.longestGame))").foregroundColor(.black).font(.system(size: 10))
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
                VStack {
                    Text("Shortest Game").foregroundColor(.black).underline().bold().font(.system(size: 10))
                    Text("Game Duration \(self.getTime(seconds: stats.shortestGame.gameInfo.gameDuration))").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills: \(stats.shortestGame.team1.kills + stats.shortestGame.team2.kills)").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills Per Min: \(self.getKPM(game: stats.shortestGame))").foregroundColor(.black).font(.system(size: 10))
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
                VStack {
                    Text("Bloodiest Game").foregroundColor(.black).underline().bold().font(.system(size: 10))
                    Text("Game Duration \(self.getTime(seconds: stats.bloodiestByTotalKill.gameInfo.gameDuration))").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills: \(stats.bloodiestByTotalKill.team1.kills + stats.bloodiestByTotalKill.team2.kills)").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills Per Min: \(self.getKPM(game: stats.bloodiestByTotalKill))").foregroundColor(.black).font(.system(size: 10))
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
                VStack {
                    Text("Bloodiest Game (By Min)").foregroundColor(.black).underline().bold().font(.system(size: 10))
                    Text("Game Duration \(self.getTime(seconds: stats.bloodiestByKillsPerMin.gameInfo.gameDuration))").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills: \(stats.bloodiestByKillsPerMin.team1.kills + stats.bloodiestByKillsPerMin.team2.kills)").foregroundColor(.black).font(.system(size: 10))
                    Text("Kills Per Min: \(self.getKPM(game: stats.bloodiestByKillsPerMin))").foregroundColor(.black).font(.system(size: 10))
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
                VStack {
                    Text("Most Played Champion").foregroundColor(.black).underline().bold().font(.system(size: 10))
                    Image("\(stats.mostPlayedChamp)").resizable().frame(width: 50, height: 50)
                    Text("Games: \(stats.mostPlayedChampGameCount)").foregroundColor(.black).font(.system(size: 10))
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
                VStack {
                    Text("Highest WR Champion").foregroundColor(.black).underline().bold().font(.system(size: 10))
                    Image("\(stats.highestWRChamp)").resizable().frame(width: 50, height: 50)
                    Text("WR: \(String(format: "%.2f", stats.highestWRChampWR))%").foregroundColor(.black).font(.system(size: 10))
                }.frame(width: 150, height: 100).border(Color(UIColor.lightGray), width: 0.5)
                
            }.padding()
        }
    }
    
    private func getTime(seconds: Int) -> String {
        var sec = "\(seconds % 60)"
        if sec.count == 1 {
            sec = "0" + sec
        }
        return "\(seconds / 60):\(sec)"
    }
    
    private func getKPM(game: Game) -> String {
        let kills = Double(game.team1.kills + game.team2.kills)
        let mins = Double(game.gameInfo.gameDuration) / 60.0
        return String(format: "%.2f", kills / mins)
    }
}
