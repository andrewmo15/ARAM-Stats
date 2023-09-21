//
//  Game.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import Foundation

struct Game: Identifiable, Hashable {
    var id: String
    var gameInfo: Info
    var userGameDetails: Participant
    var team1: Team
    var team2: Team
}

struct Info: Hashable {
    var gameDuration: Int
    var daysElapsed: Int
    var gameMode: String
}

struct Team: Hashable {
    var participants: [Participant]
    var isBlueSide: Bool
    var win: Bool
    var kills: Int
    var deaths: Int
    var assists: Int
    var turretsLost: Int
    var inhibitorsLost: Int
    var maxDamage: Int
}

struct Participant: Identifiable, Hashable {
    var assists: Int
    var champLevel: Int
    var championName: String
    var deaths: Int
    var goldEarned: Int
    var item0: String
    var item1: String
    var item2: String
    var item3: String
    var item4: String
    var item5: String
    var item6: String
    var kills: Int
    var id: String
    var rune1: String
    var rune2: String
    var summoner1Id: String
    var summoner2Id: String
    var summonerLevel: Int
    var summonerName: String
    var teamId: Int
    var totalDamageDealtToChampions: Int
    var totalDamageTaken: Int
    var totalMinionsKilled: Int
    var win: Bool
}
