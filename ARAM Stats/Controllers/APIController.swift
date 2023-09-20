//
//  APIController.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import Foundation

class APIController: ObservableObject {
    
    @Published var games: [Game] = []
    private let api = APIService()
    
    func fetchGames(username: String) {
        Task(priority: .background) {
            let userResult: Result<String, Error> = await api.getUser(username: username)
            guard case .success(let puuid) = userResult else {
                return
            }
            let gameIDsResult: Result<[String], Error> = await api.getGameIDs(puuid: puuid)
            guard case .success(let gameIDs) = gameIDsResult else {
                return
            }
            var gameDetails: [Game] = []
            for gameID in gameIDs {
                let gameResult: Result<Game, Error> = await api.getGameDetails(puuid: puuid, gameID: gameID)
                guard case .success(let game) = gameResult else {
                    return
                }
                if game.gameInfo.gameMode == "ARAM" {
                    gameDetails.append(game)
                }
                if self.games.count == 20 {
                    break
                }
            }
            self.games = gameDetails
        }
    }
}

struct APIService {
    
    private let apikey = "RGAPI-c7866c26-8627-4e1f-9b77-1fbef12b47b4"
    private let dataProcess = DataProcess()
    
    func getUser(username: String) async -> Result<String, Error> {
        do {
            let url = URL(string: "https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(username)")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apikey, forHTTPHeaderField: "X-Riot-Token")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let user =  try JSONDecoder().decode(UserAPI.self, from: data)
            return .success(user.puuid)
        } catch let error {
            return .failure(error)
        }
    }
    
    func getGameIDs(puuid: String) async -> Result<[String], Error> {
        do {
            let url = URL(string: "https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/\(puuid)/ids?type=normal&start=0&count=1")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apikey, forHTTPHeaderField: "X-Riot-Token")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let games =  try JSONDecoder().decode([String].self, from: data)
            return .success(games)
        } catch let error {
            return .failure(error)
        }
    }
    
    func getGameDetails(puuid: String, gameID: String) async -> Result<Game, Error> {
        do {
            let url = URL(string: "https://americas.api.riotgames.com/lol/match/v5/matches/\(gameID)")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apikey, forHTTPHeaderField: "X-Riot-Token")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let game = try JSONDecoder().decode(GameAPI.self, from: data)
            let gameIterator = dataProcess.processData(game: game, gameID: gameID, puuid: puuid)
            return .success(gameIterator)
        } catch let error {
            return .failure(error)
        }
    }
}
