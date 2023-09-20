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
    
    @State private var selection: SearchUser.ID?
    @State private var path = [SearchUser]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    TextField("Search Summoner", text: $username, onCommit: {
                        let searchUser = SearchUser(context: moc)
                        searchUser.id = UUID()
                        searchUser.username = username
                        searchUser.region = region
                        try? moc.save()
                        present = true
                    }).padding()
                    Picker("Region", selection: $region) {
                        ForEach(regions, id: \.self) { reg in
                            Text("\(reg)")
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Recent History").padding()
                    Table(searchUsers.suffix(10), selection: $selection) {
                        TableColumn("Recent Searches") { user in
                            Text("\(user.username ?? "")")
                        }
                    }
                }
            }.navigationDestination(isPresented: $present) {
                GameOverviewView(username: username, region: region)
            }.navigationDestination(for: SearchUser.self) { user in
                GameOverviewView(username: user.username ?? "", region: user.region ?? "")
            }.onAppear {
                selection = nil
                present = false
            }
        }.onChange(of: selection) { selection in
            if let selection = selection, let user = searchUsers.first(where: {$0.id == selection}) {
                path.append(user)
            }
        }
    }
}

