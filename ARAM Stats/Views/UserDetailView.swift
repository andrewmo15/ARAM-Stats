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
                Text("\(user.championName)")
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            Text("\(user.summoner1Id)")
                            Text("\(user.summoner2Id)")
                        }
                        VStack {
                            Text("\(user.rune1)")
                            Text("\(user.rune2)")
                        }
                    }
                    VStack {
                        HStack {
                            Text("\(user.item0)")
                            Text("\(user.item1)")
                            Text("\(user.item2)")
                            Text("\(user.item3)")
                            Text("\(user.item4)")
                            Text("\(user.item5)")
                            Text("\(user.item6)")
                        }
                        Text("\(user.kills)/\(user.deaths)/\(user.assists)")
                    }
                }
            }
        }
    }
}
