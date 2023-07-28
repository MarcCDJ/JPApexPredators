//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Marc Cruz on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    let apController = PredatorController()
    @State var sortAlphabetical = false
    @State var currentFilter = "All Types"
    @State var currentMovieFilter = "All Movies"
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    var body: some View {
        // filter
        apController.filterByMovieAndType(movie: currentMovieFilter, type: currentFilter)
        
        // search
        apController.searchResults(searchText: searchText)
        
        if sortAlphabetical {
            apController.sortByAlphabetical()
        } else {
            apController.sortByMovieAppearance()
        }
        
        return NavigationView {
            List {
                ForEach(apController.apexPredators) { predator in
                    NavigationLink(destination: PredatorDetail(predator: predator)) {
                        PredatorRow(predator: predator)
                    }
                }
                if apController.apexPredators.count == 0 {
                    Text("No Predators Found!")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("Apex Predators")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            sortAlphabetical.toggle()
                        }
                    } label: {
                        if sortAlphabetical {
                            Image(systemName: "film")
                        } else {
                            Image(systemName: "textformat")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentMovieFilter.animation()) {
                            ForEach(apController.movieFilters, id: \.self) { title in
                                HStack {
                                    Text(title)
                                    Spacer()
                                    Image(systemName: title == "All Movies" ? "movieclapper.fill" : "popcorn.fill")
                                }
                            }
                        }
                        Picker("Filter", selection: $currentFilter.animation()) {
                            ForEach(apController.typeFilters, id: \.self) { type in
                                HStack {
                                    Text(type)
                                    Spacer()
                                    Image(systemName: apController.typeIcon(for: type))
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .searchable(text: $searchText, isPresented: $searchIsActive,
                    prompt: "Type in dinosaur name")
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
