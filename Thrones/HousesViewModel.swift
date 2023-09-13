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
    
    var pageNumber = 1
    let pageSize = 50
    var urlString = "https://www.anapioficeandfire.com/api/houses?page=1&pageSize=50"
    
    func getData() async {
        guard pageNumber != 0 else {return}     // Don't access more pages. You're done.
        urlString = "https://www.anapioficeandfire.com/api/houses?page=\(pageNumber)&pageSize=50"
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
            self.houses += returned
            isLoading = false
            if returned.count < pageSize {
                pageNumber = 0
            } else {
                pageNumber += 1
                }
            
        } catch {
            print("😡 ERROR: Could not use URL at \(urlString) to get data and response --> \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func loadNextIfNeeded(house: House) async {
        guard let lastHouse = houses.last else {
            return
        }
        if house.id == lastHouse.id && pageNumber != 0 {
            Task {
                await getData()
            }
        }
    }
    
    func loadAll() async {
        guard pageNumber != 0 else {return}
        await getData()
        await loadAll()
    }
}
