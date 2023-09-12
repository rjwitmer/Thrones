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
            List(housesVM.houses) { house in
                Text(house.name)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Houses of Westeros")
        }
        .task {
            await housesVM.getData()
            print("housesVM.houses.count = \(housesVM.houses.count)")
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
