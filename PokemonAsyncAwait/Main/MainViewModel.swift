//
//  MainViewModel.swift
//  PokemonAsyncAwait
//
//  Created by Filip Bulander on 17.06.2023.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    private var pokemonProvider = PokemonDataProvider()
    
    @Published var url = ImageUrlProvider.getUrlFrom(pokemonId: "1")
    @Published var pokemonName: String = ""
    @Published var pokemonHeight: Double = 0
    @Published var pokemonWeight: Double = 0
    
    @Published var pokemonId: String = "1" {
        didSet {
            DispatchQueue.main.async {
                self.url = ImageUrlProvider.getUrlFrom(pokemonId: self.pokemonId)
            }
        }
    }
    
    
    
    func evolvePokemon() async {
        do {
            let chain = try await pokemonProvider.createEvolutionChain(id: pokemonId)
            let name = chain.chain.evolves_to.first?.species.name
            let newPokemon = try await pokemonProvider.downloadPokemon(id: name ?? "")
            await processNewPokemon(pokemon: newPokemon)
        } catch {
            
        }
    }
    
    func generatePokemon() async {
//        DispatchQueue.main.async { [weak self] in
        await MainActor.run { [weak self] in
            self?.pokemonId = Int.random(in: 1...100).formatted()
        }
        do {
            let newPokemon = try await pokemonProvider.downloadPokemon(id: pokemonId)
            await processNewPokemon(pokemon: newPokemon)
        } catch {
            
        }
    }
    
    func refreshPokemon() async {
        do {
            let newPokemon = try await pokemonProvider.downloadPokemon(id: pokemonId)
            await processNewPokemon(pokemon: newPokemon)
        } catch {
            
        }
    }
    
    private func processNewPokemon(pokemon: Pokemon) async {
        await MainActor.run {
            pokemonId = pokemon.id.description
            pokemonName = pokemon.name
            pokemonHeight = pokemon.height
            pokemonWeight = pokemon.weight
        }
    }
}
