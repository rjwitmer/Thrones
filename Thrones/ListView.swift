//
//  ListView.swift
//  Thrones
//
//  Created by Bob Witmer on 2023-09-11.
//

import SwiftUI

struct ListView: View {
    @StateObject var housesVM = HousesViewModel()
    //@State private var houses: [String] = ["Targaryen", "Lannister", "Stark", "Martell", "Greyjoy"]
    var body: some View {
        NavigationStack {
            ZStack {
                List(housesVM.houses) { house in
                    LazyVStack(alignment: .leading) {
                        NavigationLink(destination: DetailView(house: house)) {
                            Text(house.name)
                                .font(.title2)
                        }

                    }
                    .onAppear {
                        Task {
                            await housesVM.loadNextIfNeeded(house: house)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Houses of Westeros")
                
                if housesVM.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
                }
            }
        }
        .task {
            await housesVM.getData()
            print("housesVM.houses.count = \(housesVM.houses.count)")
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Load All") {
                    Task {
                        await housesVM.loadAll()
                    }
                }
            }
            ToolbarItem(placement: .status) {
                Text("\(housesVM.houses.count) Houses Returned")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView()
        }
    }
}
