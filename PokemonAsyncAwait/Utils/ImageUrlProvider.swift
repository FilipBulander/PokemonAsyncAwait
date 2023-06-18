//
//  ImageUrlProvider.swift
//  PokemonAsyncAwait
//
//  Created by Filip Bulander on 18.06.2023.
//

import Foundation

struct ImageUrlProvider {
    static func getUrlFrom(pokemonId: String) -> URL {
        let baseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        let imgType = ".png"
        let urlString = baseUrl + pokemonId + imgType
        guard let url = URL(string: urlString) else {
            fatalError("Invalid url")
        }
        return url
    }
}
