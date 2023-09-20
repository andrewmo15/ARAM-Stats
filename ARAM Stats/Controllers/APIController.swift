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
    
    func fetchGames(username: String, region: String) {
        Task(priority: .background) {
            let userResult: Result<String, Error> = await api.getUser(username: username, region: region)
            guard case .success(let puuid) = userResult else {
                return
            }
            let gameIDsResult: Result<[String], Error> = await api.getGameIDs(puuid: puuid, region: region)
            guard case .success(let gameIDs) = gameIDsResult else {
                return
            }
            var gameDetails: [Game] = []
            for gameID in gameIDs {
                let gameResult: Result<Game, Error> = await api.getGameDetails(puuid: puuid, gameID: gameID, region: region)
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
    
    private var regionMap: Dictionary<String, String> = [
        "NA": "americas",
        "BR": "americas",
        "LAN": "americas",
        "LAS": "americas",
        "KR": "asia",
        "JP": "asia",
        "EUNE": "europe",
        "EUW": "europe",
        "TR": "europe",
        "RU": "europe",
        "OCE": "sea",
        "PH2": "sea",
        "SG2": "sea",
        "TH2": "sea",
        "TW2": "sea",
        "VN2": "sea",
    ]
    
    private var regionCodeMap: Dictionary<String, String> = [
        "NA": "na1",
        "BR": "br1",
        "LAN": "la1",
        "LAS": "la2",
        "KR": "kr",
        "JP": "jp1",
        "EUNE": "eun1",
        "EUW": "euw1",
        "TR": "tr1",
        "RU": "ru",
        "OCE": "oc1",
        "PH2": "ph2",
        "SG2": "sg2",
        "TH2": "th2",
        "TW2": "tw2",
        "VN2": "vn2",
    ]
    
    func getUser(username: String, region: String) async -> Result<String, Error> {
        do {
            let url = URL(string: "https://\(regionCodeMap[region]!).api.riotgames.com/lol/summoner/v4/summoners/by-name/\(username)")!
            
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
    
    func getGameIDs(puuid: String, region: String) async -> Result<[String], Error> {
        do {
            let url = URL(string: "https://\(regionMap[region]!).api.riotgames.com/lol/match/v5/matches/by-puuid/\(puuid)/ids?type=normal&start=0&count=1")!
            
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
    
    func getGameDetails(puuid: String, gameID: String, region: String) async -> Result<Game, Error> {
        do {
            let url = URL(string: "https://\(regionMap[region]!).api.riotgames.com/lol/match/v5/matches/\(gameID)")!
            
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
