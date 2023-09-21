//
//  UserDetailView.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/18/23.
//

import SwiftUI

struct UserDetailView: View {
    
    @State var user: Participant
    @State var maxDamage: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.white)
                .frame(height: 50)
            HStack(spacing: 20) {
                HStack {
                    Image(user.championName).resizable().frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Image(user.summoner1Id).resizable().frame(width: 17, height: 17).padding(-1)
                                Image(user.summoner2Id).resizable().frame(width: 17, height: 17).padding(-1)
                            }
                            VStack(alignment: .leading) {
                                Image(user.rune1).resizable().frame(width: 17, height: 17).padding(-1)
                                Image(user.rune2).resizable().frame(width: 17, height: 17).padding(-1)
                            }
                            VStack(alignment: .leading) {
                                Text("\(user.summonerName)")
                                    .font(.system(size: 12))
                                    .lineLimit(1)
                                    .foregroundColor(.black)
                                Text("\(user.kills) / \(user.deaths) / \(user.assists)")
                                    .font(.system(size: 12))
                                    .lineLimit(1)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 5)
                VStack(alignment: .trailing) {
                    HStack {
                        Image(user.item0).resizable().frame(width: 17, height: 17)
                        Image(user.item1).resizable().frame(width: 17, height: 17)
                        Image(user.item2).resizable().frame(width: 17, height: 17)
                        Image(user.item3).resizable().frame(width: 17, height: 17)
                        Image(user.item4).resizable().frame(width: 17, height: 17)
                        Image(user.item5).resizable().frame(width: 17, height: 17)
                        Image(user.item6).resizable().frame(width: 17, height: 17)
                    }
                    HStack {
                        Text("\(user.totalDamageDealtToChampions)").foregroundColor(user.win ? .blue : .red).font(.system(size: 9))
                        ProgressView(value: Double(user.totalDamageDealtToChampions) / Double(self.maxDamage)) {
                            EmptyView()
                        }.tint(user.win ? .blue : .red)
                    }
                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
            }
        }
    }
}
