//
//  ListViewModel.swift
//  PokemonAsyncAwait
//
//  Created by Filip Bulander on 18.06.2023.
//

import Foundation

class ListViewModel: ObservableObject {
    private let dataProvider = PokemonDataProvider()
    
    @Published var pokemons: [Pokemon] = []
    private var pokemonIds = ["1", "2", "3"]
    
    func synchronousRefresh() async {
        do {
            let firstPokemon = try await dataProvider.downloadPokemon(id: pokemonIds[0])
            let secondPokemon = try await dataProvider.downloadPokemon(id: pokemonIds[1])
            let thirdPokemon = try await dataProvider.downloadPokemon(id: pokemonIds[2])
            
            let pokemons = [firstPokemon, secondPokemon, thirdPokemon]
            await MainActor.run {
                self.pokemons = pokemons
                print("Refreshed")
            }
        } catch {
            
        }
    }
    
    func paralelRefresh() async {
        do {
            async let firstPokemon = try await dataProvider.downloadPokemon(id: pokemonIds[0])
            async let secondPokemon = try await dataProvider.downloadPokemon(id: pokemonIds[1])
            async let thirdPokemon = try await dataProvider.downloadPokemon(id: pokemonIds[2])
            
            let pokemons = try await [firstPokemon, secondPokemon, thirdPokemon]
            await MainActor.run {
                self.pokemons = pokemons
                print("Refreshed")
            }
        } catch {
            
        }
    }
    
    func generateNewIds() {
        for i in 0...2 {
            pokemonIds[i] = Int.random(in: 0...100).description
        }
    }
}
