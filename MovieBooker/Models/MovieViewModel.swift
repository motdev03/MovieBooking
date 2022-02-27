//
//  MovieViewModel.swift
//  MovieBooker
//
//  Created by Tom Manuel on 27/02/22.
//

import Foundation

enum HomeSection: String, CaseIterable {
    case Trending
    case Popular
    case Upcoming
    case Actors
}

class MovieViewModel: ObservableObject {
    @Published var allItems: [HomeSection:[Codable]] = [:]
        init() {
            getAll()
        }
        
        private func getAll(){
            if let path = Bundle.main.path(forResource: "data", ofType: "json") {
                
                do {
                    let url = URL(fileURLWithPath: path)
                    let data = try Data(contentsOf: url, options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MovieBundle.self, from: data)
                    allItems = [HomeSection.Trending: result.trending,
                                HomeSection.Popular: result.popular,
                                HomeSection.Upcoming: result.upcoming,
                                HomeSection.Actors: result.actors]
                    
                } catch let e{
                    print(e)
                }
            }
        }
}
