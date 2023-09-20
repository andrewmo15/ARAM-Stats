//
//  Game.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import Foundation

struct GameAPI: Decodable {
    var info: InfoAPI
}

struct InfoAPI: Decodable {
    var gameDuration: Int
    var gameStartTimestamp: Int
    var gameMode: String
    var participants: [GameUser]
}

struct GameUser: Decodable {
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
    var puuid: String
    var perks: Perks
    var summoner1Id: Int
    var summoner2Id: Int
    var summonerLevel: Int
    var summonerName: String
    var teamId: Int
    var totalDamageDealtToChampions: Int
    var totalDamageTaken: Int
    var totalMinionsKilled: Int
    var turretsLost: Int
    var inhibitorsLost: Int
    var win: Bool
}

struct Perks: Decodable {
    var styles: [Style]
}

struct Style: Decodable {
    var description: String
    var selections: [Perk]
    var style: Int
}

struct Perk: Decodable {
    var perk: Int
}
