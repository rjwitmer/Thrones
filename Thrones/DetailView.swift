//
//  DetailView.swift
//  Thrones
//
//  Created by Bob Witmer on 2023-09-13.
//

import SwiftUI

struct DetailView: View {
    let house: House
    var body: some View {
        VStack(alignment: .leading) {
            Text(house.name)
                .font(.largeTitle)
                .bold()

            Text("Region:")
                .bold()
                .padding(.top)
            if house.region.isEmpty {
                Text("n/a")
                    .italic()
            } else {
                Text(house.region)
                    .italic()
            }
            
            Text("Coat of Arms:")
                .bold()
                .padding(.top)
            if house.coatOfArms.isEmpty {
                Text("n/a")
                    .italic()
            } else {
                Text(house.coatOfArms)
                    .italic()
            }

            Text("Words:")
                .bold()
                .padding(.top)
            if house.words.isEmpty {
                Text("n/a")
                    .italic()
            } else {
                Text(house.words)
                    .italic()
            }
            
            Spacer()

        }
        .navigationBarTitleDisplayMode(.inline)
        .font(.title)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(house: House(url: "", name: "House Swift", region: "Swifteros", coatOfArms: "Orange Bird", words: "Our Code is True", titles: [""], seats: [""], currentLord: "", heir: "", overlord: "", founded: "", founder: "", diedOut: "", ancestralWeapons: [""], cadetBranches: [""], swornMembers: [""]))
    }
}
