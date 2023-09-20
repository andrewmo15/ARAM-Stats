//
//  UserDetailView.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import SwiftUI

struct UserDetailView: View {
    
    @State var user: Participant
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.red)
                .frame(height: 50)
            HStack(spacing: 20) {
                HStack {
                    Image(user.championName).resizable().frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                Image(user.summoner1Id).resizable().frame(width: 17, height: 17)
                                Image(user.summoner2Id).resizable().frame(width: 17, height: 17)
                            }
                            VStack {
                                Image(user.rune1).resizable().frame(width: 17, height: 17)
                                Image(user.rune2).resizable().frame(width: 17, height: 17)
                            }
                            VStack {
                                Text("\(user.summonerName)").font(.system(size: 15))
                                Text("\(user.kills)/\(user.deaths)/\(user.assists)").font(.system(size: 15))
                            }
                        }
                    }
                }
                VStack {
                    HStack {
                        Image(user.item0).resizable().frame(width: 17, height: 17)
                        Image(user.item1).resizable().frame(width: 17, height: 17)
                        Image(user.item2).resizable().frame(width: 17, height: 17)
                        Image(user.item3).resizable().frame(width: 17, height: 17)
                        Image(user.item4).resizable().frame(width: 17, height: 17)
                        Image(user.item5).resizable().frame(width: 17, height: 17)
                        Image(user.item6).resizable().frame(width: 17, height: 17)
                    }
                    Text("\(user.totalDamageDealtToChampions)/\(user.totalDamageTaken)").font(.system(size: 15))
                }
            }
        }
    }
}
