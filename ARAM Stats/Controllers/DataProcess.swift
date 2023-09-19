//
//  DataProcess.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import Foundation

class DataProcess {
    
    func processData(game: GameAPI, gameID: String, puuid: String) -> Game {
        let user = self.getUserGameDetails(game: game, puuid: puuid)
        return Game(
            id: gameID,
            gameInfo: self.getGameInfo(info: game.info),
            userGameDetails: user!,
            team1: self.getTeam(win: user!.win, users: game.info.participants),
            team2: self.getTeam(win: !(user!.win), users: game.info.participants))
    }
    
    private func getUserGameDetails(game: GameAPI, puuid: String) -> Participant? {
        for participant in game.info.participants {
            if participant.puuid == puuid {
                return self.getUser(user: participant)
            }
        }
        return nil
    }
    
    private func getGameInfo(info: InfoAPI) -> Info {
        return Info(gameDuration: info.gameDuration, daysElapsed: self.getDate(unix: info.gameStartTimestamp), gameMode: info.gameMode)
    }
    
    private func getTeam(win: Bool, users: [GameUser]) -> Team {
        var participants: [Participant] = []
        var kills = 0
        var deaths = 0
        var assists = 0
        var inhibitors = 0
        var turrets = 0
        for user in users {
            if user.win == win {
                participants.append(self.getUser(user: user))
                kills += user.kills
                deaths += user.deaths
                assists += user.assists
            } else {
                inhibitors = user.inhibitorsLost
                turrets = user.turretsLost
            }
        }
        return Team(participants: participants, isBlueSide: win, win: win, kills: kills, deaths: deaths, assists: assists, turretsLost: turrets, inhibitorsLost: inhibitors)
    }
    
    private func getUser(user: GameUser) -> Participant {
        return Participant(
            assists: user.assists,
            champLevel: user.champLevel,
            championName: user.championName,
            deaths: user.deaths,
            goldEarned: user.goldEarned,
            item0: user.item0,
            item1: user.item1,
            item2: user.item2,
            item3: user.item3,
            item4: user.item4,
            item5: user.item5,
            item6: user.item6,
            kills: user.kills,
            id: user.puuid,
            rune1: user.perks.styles[0].selections[0].perk,
            rune2: user.perks.styles[1].selections[0].perk,
            summoner1Id: user.summoner1Id,
            summoner2Id: user.summoner2Id,
            summonerLevel: user.summonerLevel,
            summonerName: user.summonerName,
            teamId: user.teamId,
            totalDamageDealtToChampions: user.totalDamageDealtToChampions,
            totalDamageTaken: user.totalDamageTaken,
            totalMinionsKilled: user.totalMinionsKilled,
            win: user.win
        )
    }
    
    private func getDate(unix: Int) -> Int {
        let gameDate = Date(timeIntervalSince1970: TimeInterval(unix / 1000))
        let today = Date()
        let calendar = Calendar.current
        let startOfDate1 = calendar.startOfDay(for: gameDate)
        let startOfDate2 = calendar.startOfDay(for: today)
        if let days = calendar.dateComponents([.day], from: startOfDate1, to: startOfDate2).day {
            return abs(days)
        }
        return -1
    }
}
