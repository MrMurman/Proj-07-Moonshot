//
//  ContentView.swift
//  Proj-07-Moonshot
//
//  Created by Андрей Бородкин on 19.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingListView = false
    
    var body: some View {
        NavigationView {
            Group {
                if showingListView {
                    List {
                        ForEach(missions) {mission in

                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                ListItemView(mission: mission, listPresenting: true)
                            }
                        }
                    }
                }
                  else {
                      ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) {mission in
                                
                                NavigationLink{
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    ListItemView(mission: mission)
                                    
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
                
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar(content: {
                ToolbarItem(placement: .automatic) {
                    Button("Change") {
                        withAnimation{
                            showingListView.toggle()
                        }
                    }
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListItemView: View {
    var mission: Mission
    var listPresenting: Bool?
    
    var body: some View {
        Group {
            if let listPresenting = listPresenting, listPresenting == true {
                HStack {
                    StackContentView(mission: mission)
                }
            } else {
                    VStack{
                        StackContentView(mission: mission)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground))
        }
}

struct StackContentView: View {
    
    var mission: Mission
    
    var body: some View {
        Group {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack{
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(.lightBackground)
        }
    }
}
