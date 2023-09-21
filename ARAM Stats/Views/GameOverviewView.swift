//
//  GameOverviewView.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/19/23.
//

import SwiftUI

struct GameOverviewView: View {
    
    @State var username: String
    @State var region: String
    @StateObject private var api = APIController()
    @State private var viewDidLoad = false

    var body: some View {
        HStack {
            Text("\(username)")
                .frame(maxWidth: .infinity, alignment: .bottomLeading).padding(.leading, 15)
                .font(.system(size: 35))
                .bold()
                .lineLimit(1)
                .foregroundColor(.white)
        }.frame(height: 50).background(.blue)
        
        ScrollView(.vertical, showsIndicators: false) {
            
            if api.isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.blue)).frame(height: 200)
            }
            VStack(spacing: -0.25) {
                ForEach(api.stats) { stat in
                    StatsCards(stats: stat)
                }
                ForEach(api.games) { game in
                    NavigationLink(destination: GameDetailView(game: game, region: region)) {
                        GameOverviewCard(game: game).border(Color(UIColor.lightGray), width: 0.5)
                    }
                }
            }
            
        }
        .onAppear {
            if !viewDidLoad {
                api.fetchGames(username: username, region: region)
            }
            viewDidLoad = true
        }
    }
}
