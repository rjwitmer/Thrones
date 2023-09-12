//
//  HousesViewModel.swift
//  Thrones
//
//  Created by Bob Witmer on 2023-09-11.
//

import Foundation

@MainActor
class HousesViewModel: ObservableObject {

    @Published var houses: [House] = []
    @Published var isLoading = false
    
    var urlString = "https://www.anapioficeandfire.com/api/houses?page=1&pageSize=50"
    
    func getData() async {
        print("🕸️ We are accessing the URL \(urlString)")
        isLoading = true
        // convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from:  url)
            
            // Try to decode JSON data into our out data structures
            guard let returned = try? JSONDecoder().decode([House].self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            self.houses = returned
            isLoading = false
        } catch {
            print("😡 ERROR: Could not use URL at \(urlString) to get data and response --> \(error.localizedDescription)")
            isLoading = false
        }
    }
}
