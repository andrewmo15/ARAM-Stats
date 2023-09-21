//
//  StatsController.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/20/23.
//

import Foundation

struct StatsController {
    
    private var games = [Game]()
    
    func getStats(games: [Game]) -> Stats {
        return Stats(winCount: self.getNumWins(games: games),
                     wr: self.getWinRate(games: games),
                     averageKDA: self.getAverageKDA(games: games),
                     simplifiedKDA: self.getSimplifiedKDA(games: games),
                     longestGame: self.getLongestGame(games: games),
                     shortestGame: self.getShortestGame(games: games),
                     bloodiestByTotalKill: self.getBloodiestGameByTotalKills(games: games),
                     bloodiestByKillsPerMin: self.getBloodiestGameByKillsPerMin(games: games),
                     mostPlayedChamp: self.getMostPlayedChampion(games: games),
                     mostPlayedChampGameCount: self.getMostPlayedChampionGameCount(games: games),
                     highestWRChamp: self.getHighestWRChampion(games: games),
                     highestWRChampWR: self.getHighestWRChampionWR(games: games))
    }
    
    private func getNumWins(games: [Game]) -> Int {
        var wins = 0
        for game in games {
            if game.userGameDetails.win {
                wins += 1
            }
        }
        return wins
    }
    
    private func getWinRate(games: [Game]) -> Double {
        var wins = 0
        for game in games {
            if game.userGameDetails.win {
                wins += 1
            }
        }
        return Double(wins) * 100.0 / Double(games.count)
    }
    
    private func getAverageKDA(games: [Game]) -> String {
        var kills = 0
        var deaths = 0
        var assists = 0
        for game in games {
            kills += game.userGameDetails.kills
            deaths += game.userGameDetails.deaths
            assists += game.userGameDetails.assists
        }
        return "\(String(format: "%.2f", Double(kills) / Double(games.count))) / \(String(format: "%.2f", Double(deaths) / Double(games.count))) / \(String(format: "%.2f", Double(assists) / Double(games.count)))"
    }
    
    private func getSimplifiedKDA(games: [Game]) -> String {
        var kills = 0
        var deaths = 0
        var assists = 0
        for game in games {
            kills += game.userGameDetails.kills
            deaths += game.userGameDetails.deaths
            assists += game.userGameDetails.assists
        }
        let averageKills = Double(kills) / Double(games.count)
        let averageDeaths = Double(deaths) / Double(games.count)
        let averageAssists = Double(assists) / Double(games.count)
        let simplifiedKDA = (averageKills + averageAssists) / averageDeaths
        return "\(String(format: "%.2f", simplifiedKDA)):1"
    }
    
    private func getLongestGame(games: [Game]) -> Game {
        return games.max { a, b in a.gameInfo.gameDuration < b.gameInfo.gameDuration }!
    }
    
    private func getShortestGame(games: [Game]) -> Game {
        return games.max { a, b in a.gameInfo.gameDuration > b.gameInfo.gameDuration }!
    }
    
    private func getBloodiestGameByTotalKills(games: [Game]) -> Game {
        return games.max { a, b in (a.team1.kills + a.team2.kills) < (b.team1.kills + b.team2.kills) }!
    }
    
    private func getBloodiestGameByKillsPerMin(games: [Game]) -> Game {
        return games.max { a, b in ((a.team1.kills + a.team2.kills) / a.gameInfo.gameDuration) < ((b.team1.kills + b.team2.kills) / b.gameInfo.gameDuration) }!
    }
    
    private func getMostPlayedChampion(games: [Game]) -> String {
        var dic : [String : Int] = [:]
        for game in games {
            if let count = dic[game.userGameDetails.championName] {
                dic[game.userGameDetails.championName] = count + 1
            } else {
                dic[game.userGameDetails.championName] = 1
            }
        }
        let high = dic.values.max()
        for (name, count) in dic {
           if count == high {
               return name
           }
        }
        return ""
    }
    
    private func getMostPlayedChampionGameCount(games: [Game]) -> Int {
        var dic : [String : Int] = [:]
        for game in games {
            if let count = dic[game.userGameDetails.championName] {
                dic[game.userGameDetails.championName] = count + 1
            } else {
                dic[game.userGameDetails.championName] = 1
            }
        }
        return dic.values.max() ?? 0
    }
    
    private func getHighestWRChampion(games: [Game]) -> String {
        var dic : [String : Int] = [:]
        var wins: [String: Int] = [:]
        for game in games {
            if let count = dic[game.userGameDetails.championName], let wincount = wins[game.userGameDetails.championName] {
                dic[game.userGameDetails.championName] = count + 1
                wins[game.userGameDetails.championName] = wincount + (game.userGameDetails.win ? 1 : 0)
            } else {
                dic[game.userGameDetails.championName] = 1
                wins[game.userGameDetails.championName] = game.userGameDetails.win ? 1 : 0
            }
        }
        
        var wr: [String : Double] = [:]
        for (champion, wincount) in wins {
            if let numGames = dic[champion] {
                if numGames >= 2 {
                    let numerator = Double(wincount) / Double(numGames)
                    wr[champion] = round(numerator * 1000.0) / 1000.0
                }
            }
        }
        let high = wr.values.max()
        for (champion, winrate) in wr {
           if winrate == high {
               return champion
           }
        }
        return ""
    }
    
    private func getHighestWRChampionWR(games: [Game]) -> Double {
        var dic : [String : Int] = [:]
        var wins: [String: Int] = [:]
        for game in games {
            if let count = dic[game.userGameDetails.championName], let wincount = wins[game.userGameDetails.championName] {
                dic[game.userGameDetails.championName] = count + 1
                wins[game.userGameDetails.championName] = wincount + (game.userGameDetails.win ? 1 : 0)
            } else {
                dic[game.userGameDetails.championName] = 1
                wins[game.userGameDetails.championName] = game.userGameDetails.win ? 1 : 0
            }
        }
        
        var wr: [String : Double] = [:]
        for (champion, wincount) in wins {
            if let numGames = dic[champion] {
                if numGames >= 2 {
                    let numerator = Double(wincount) / Double(numGames)
                    wr[champion] = round(numerator * 1000.0) / 10.0
                }
            }
        }
        return wr.values.max() ?? 0.0
    }
}
