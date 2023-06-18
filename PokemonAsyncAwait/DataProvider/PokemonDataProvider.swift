//
//  PokemonDataProvider.swift
//  PokemonAsyncAwait
//
//  Created by Filip Bulander on 17.06.2023.
//

import Foundation

struct PokemonDataProvider {
    func downloadPokemon(id: String) async throws -> Pokemon {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        let request = URLRequest(url: url)

        let pokemonData = try await URLSession.shared.data(for: request).0
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: pokemonData)
        print(id)
        return pokemon
    }

    func createEvolutionChain(id: String) async throws -> EvolutionChain {
        let url = URL(string: "https://pokeapi.co/api/v2/evolution-chain/\(id)")!
        let request = URLRequest(url: url)

        let evolutionData = try await URLSession.shared.data(for: request).0
        let evolution = try JSONDecoder().decode(EvolutionChain.self, from: evolutionData)
        return evolution
    }
}
