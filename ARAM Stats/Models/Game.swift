//
//  Game.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import Foundation

struct Game: Identifiable {
    var id: String
    var gameInfo: Info
    var userGameDetails: Participant
    var team1: Team
    var team2: Team
}

struct Info {
    var gameDuration: Int
    var daysElapsed: Int
    var gameMode: String
}

struct Team {
    var participants: [Participant]
    var isBlueSide: Bool
    var win: Bool
    var kills: Int
    var deaths: Int
    var assists: Int
    var turretsLost: Int
    var inhibitorsLost: Int
}

struct Participant: Identifiable {
    var assists: Int
    var champLevel: Int
    var championName: String
    var deaths: Int
    var goldEarned: Int
    var item0: Int
    var item1: Int
    var item2: Int
    var item3: Int
    var item4: Int
    var item5: Int
    var item6: Int
    var kills: Int
    var id: String
    var rune1: Int
    var rune2: Int
    var summoner1Id: Int
    var summoner2Id: Int
    var summonerLevel: Int
    var summonerName: String
    var teamId: Int
    var totalDamageDealtToChampions: Int
    var totalDamageTaken: Int
    var totalMinionsKilled: Int
    var win: Bool
}
