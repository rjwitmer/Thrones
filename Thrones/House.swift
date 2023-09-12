//
//  House.swift
//  Thrones
//
//  Created by Bob Witmer on 2023-09-11.
//

import Foundation

struct House: Codable, Identifiable {
    let id = UUID().uuidString
    var url: String
    var name: String
    var region: String
    var coatOfArms: String
    var words: String
    var titles: [String]
    var seats: [String]
    var currentLord: String
    var heir: String
    var overlord: String
    var founded: String
    var founder: String
    var diedOut: String
    var ancestralWeapons: [String]
    var cadetBranches: [String]
    var swornMembers: [String]
    
    enum CodingKeys: CodingKey {
        case url, name, region, coatOfArms, words, titles, seats, currentLord, heir, overlord, founded, founder, diedOut, ancestralWeapons, cadetBranches, swornMembers
    }
}
