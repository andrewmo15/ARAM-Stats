//
//  ContentView.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/15/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var searchUsers: FetchedResults<SearchUser>
    
    @State private var username: String = ""
    @State private var present = false
    @State private var region: String = "NA"
    @State private var regions: [String] = ["NA","BR","LAN","LAS","KR","JP","EUNE","EUW","TR","RU","OCE","PH2","SG2","TH2","TW2","VN2"]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        TextField("Enter your name", text: $username, onCommit: {
                            let searchUser = SearchUser(context: moc)
                            searchUser.id = UUID()
                            searchUser.user = username
                            try? moc.save()
                            present = true
                        }).padding()
                        Picker("Region", selection: $region) {
                            ForEach(regions, id: \.self) { reg in
                                Text("\(reg)")
                            }
                        }
                    }
                    VStack {
                        ForEach(searchUsers.suffix(5).reversed()) { user in
                            Text(user.user ?? "N/A").foregroundColor(.black)
                        }
                    }
                }
            }.navigationDestination(isPresented: $present) {
                GameOverviewView(username: username, region: region)
            }
        }
    }
}
