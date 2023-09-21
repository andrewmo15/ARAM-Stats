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
    
    @State var dataControllerError: String?
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
                    Text("ARAM Stats")
                        .frame(maxWidth: .infinity, alignment: .bottomLeading).padding(.leading, 15)
                        .font(.system(size: 35))
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(.blue)
                }.frame(height: 50).background(.white)
                
                HStack(spacing: -0.25) {
                    TextField("Search Summoner", text: $username, onCommit: {
                        let searchUser = SearchUser(context: moc)
                        searchUser.id = UUID()
                        searchUser.username = username
                        searchUser.region = region
                        try? moc.save()
                        present = true
                    }).accentColor(.blue).frame(height: 50).autocapitalization(.none)
                        .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(lineWidth: 0)
                                .border(Color(UIColor.lightGray), width: 0.5)
                        )
                    
                    Picker("Region", selection: $region) {
                        ForEach(regions, id: \.self) { reg in
                            Text("\(reg)")
                        }
                    }.accentColor(.black).frame(height: 50).border(Color(UIColor.lightGray), width: 0.5)
                }.padding(15)
                VStack(alignment: .leading) {
                    if let error = self.dataControllerError {
                        Text("\(error)").frame(height: 200)
                    } else {
                        HStack {
                            Text("Recent Searches").bold().padding().frame(maxWidth: .infinity, alignment: .leading)
                            Button("Delete All"){
                                self.deleteSearchHistory()
                            }.frame(maxWidth: .infinity, alignment: .trailing).foregroundColor(.gray).padding(.trailing, 10)
                        }
                        Table(searchUsers.suffix(10), selection: $selection) {
                            TableColumn("Recent Searches") { user in
                                Text("\(user.username ?? "")")
                            }
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
        }.accentColor(.white)
    }
    
    private func deleteSearchHistory() {
        for user in searchUsers {
            moc.delete(user)
        }
        try? moc.save()
    }
}

