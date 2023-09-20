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
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(height: 100)
            HStack {
                Image(user.championName).resizable().frame(width: 32.0, height: 32.0)
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            Image(user.summoner1Id).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.summoner2Id).resizable().frame(width: 32.0, height: 32.0)
                        }
                        VStack {
                            Image(user.rune1).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.rune2).resizable().frame(width: 32.0, height: 32.0)
                        }
                    }
                    VStack {
                        HStack {
                            Image(user.item0).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.item1).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.item2).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.item3).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.item4).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.item5).resizable().frame(width: 32.0, height: 32.0)
                            Image(user.item6).resizable().frame(width: 32.0, height: 32.0)
                        }
                        Text("\(user.kills)/\(user.deaths)/\(user.assists)")
                    }
                }
            }
        }
    }
}
