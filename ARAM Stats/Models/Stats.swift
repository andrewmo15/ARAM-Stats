//
//  Stats.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/20/23.
//

import Foundation

struct Stats: Identifiable {
    var id = UUID()
    var winCount: Int
    var wr: Double
    var averageKDA: String
    var simplifiedKDA: String
    var longestGame: Game
    var shortestGame: Game
    var bloodiestByTotalKill: Game
    var bloodiestByKillsPerMin: Game
    var mostPlayedChamp: String
    var mostPlayedChampGameCount: Int
    var highestWRChamp: String
    var highestWRChampWR: Double
}
