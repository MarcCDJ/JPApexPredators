//
//  PredatorController.swift
//  JP Apex Predators
//
//  Created by Marc Cruz on 7/27/23.
//

import Foundation

class PredatorController {
    private var allApexPredators: [ApexPredator] = []
    private var apexPredatorsTmp: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    var typeFilters = ["All Types", "Land", "Air", "Sea"]
    var movieFilters: [String] = ["All Movies"]

    init() {
        decodeApexPredatorData()
    }

    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)

                allApexPredators.forEach { predator in
                    predator.movies.forEach { movie in
                        guard !movieFilters.contains(movie) else { return }
                        movieFilters.append(movie)
                    }
                }
                movieFilters.sort(by: { $0 < $1 })
                
                apexPredators = allApexPredators
                apexPredatorsTmp = apexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func filterByMovieAndType(movie: String, type: String) {
        apexPredatorsTmp = allApexPredators
        
        // first, filter by movie
        apexPredatorsTmp = apexPredatorsTmp.filter {
            movie == "All Movies" ? !$0.movies.isEmpty : $0.movies.contains(movie)
        }
        
        // now, filter by type
        apexPredators = apexPredatorsTmp.filter {
            type == "All Types" ? !$0.type.isEmpty : $0.type == type.lowercased()
        }
    }

    func typeIcon(for type: String) -> String {
        switch type {
            case "All Types": return "square.stack.3d.up.fill"
            case "Land": return "leaf.fill"
            case "Air": return "wind"
            case "Sea": return "drop.fill"
            default: return "questionmark"
        }
    }

    func sortByAlphabetical() {
        apexPredators.sort(by: { $0.name < $1.name })
    }

    func sortByMovieAppearance() {
        apexPredators.sort(by: { $0.id < $1.id })
    }
    
    func searchResults(searchText: String) {
        if !searchText.isEmpty {
            apexPredators = apexPredators.filter { $0.name.contains(searchText) }
        }
    }
}
