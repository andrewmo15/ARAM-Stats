//
//  DataProcess.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import Foundation

class DataProcess {
    
    private var runeMap: Dictionary<Int, String> = Dictionary<Int, String>()
    private var summonerSpellMap: Dictionary<Int, String> = Dictionary<Int, String>()
    var error: String?
    
    init() {
        self.loadRunes()
        self.getSummonerSpells()
    }
    
    private func getSummonerSpells() {
        if let url = Bundle.main.url(forResource: "summoner", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Dictionary<String, Any> {
                    if let jsonData = jsonResult["data"] as? Dictionary<String, Dictionary<String, Any>> {
                        for (name, dic) in jsonData {
                            for (key, val) in dic {
                                if key == "key" {
                                    self.summonerSpellMap[Int(val as? String ?? "-1") ?? -1] = name
                                }
                            }
                        }
                        return
                    }
                }
                self.error = "Could not load summoner spell data"
            } catch {
                // handle error
                self.error = "Could not load summoner spell data"
            }
        } else {
            self.error = "Could not load summoner spell data"
        }
    }
    
    private func loadRunes() {
        if let url = Bundle.main.url(forResource: "runesReforged", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let runes = try JSONDecoder().decode([Runes].self, from: data)
                for rune in runes {
                    var arr = rune.icon.split(separator: "/")
                    self.runeMap[rune.id] = String(arr[arr.count - 1].split(separator: ".")[0])
                    for slot in rune.slots {
                        for r in slot.runes {
                            arr = r.icon.split(separator: "/")
                            self.runeMap[r.id] = String(arr[arr.count - 1].split(separator: ".")[0])
                        }
                    }
                }
            } catch {
                self.error = "Could not load summoner spell data"
            }
        }
    }
    
    func processData(game: GameAPI, gameID: String, puuid: String) -> Game? {
        if let user = self.getUserGameDetails(game: game, puuid: puuid) {
            return Game(
                id: gameID,
                gameInfo: self.getGameInfo(info: game.info),
                userGameDetails: user,
                team1: self.getTeam(win: user.win, users: game.info.participants),
                team2: self.getTeam(win: !(user.win), users: game.info.participants))
        }
        self.error = "Could not process data"
        return nil
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
        var maxDamage = 0
        for user in users {
            if user.win == win {
                participants.append(self.getUser(user: user))
                kills += user.kills
                deaths += user.deaths
                assists += user.assists
                maxDamage = max(maxDamage, user.totalDamageDealtToChampions)
            } else {
                inhibitors = user.inhibitorsLost
                turrets = user.turretsLost
            }
        }
        return Team(participants: participants, isBlueSide: win, win: win, kills: kills, deaths: deaths, assists: assists, turretsLost: turrets, inhibitorsLost: inhibitors, maxDamage: maxDamage)
    }
    
    private func getUser(user: GameUser) -> Participant {
        return Participant(
            assists: user.assists,
            champLevel: user.champLevel,
            championName: user.championName,
            deaths: user.deaths,
            goldEarned: user.goldEarned,
            item0: String(user.item0),
            item1: String(user.item1),
            item2: String(user.item2),
            item3: String(user.item3),
            item4: String(user.item4),
            item5: String(user.item5),
            item6: String(user.item6),
            kills: user.kills,
            id: user.puuid,
            rune1: self.runeMap[user.perks.styles[0].selections[0].perk] ?? "",
            rune2: self.runeMap[user.perks.styles[1].style] ?? "",
            summoner1Id: self.summonerSpellMap[user.summoner1Id] ?? "",
            summoner2Id: self.summonerSpellMap[user.summoner2Id] ?? "",
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
