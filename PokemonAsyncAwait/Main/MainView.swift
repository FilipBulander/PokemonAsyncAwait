//
//  MainView.swift
//  PokemonAsyncAwait
//
//  Created by Filip Bulander on 17.06.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var vm = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: vm.url)
                pokeInfo
                Button(action: generatePokemon,
                       label: generatePokemonLabel)
                Button(action: evolvePokemon,
                       label: evolvePokemonLabel)
                Button(action: refreshPokemon,
                       label: refreshPokemonLabel)
                NavigationLink(
                    destination: ListView(),
                    label: {
                        Text("List of pokemons")
                    }
                )
            }
        }
        .task {
            await vm.refreshPokemon()
        }
        .padding()
    }
    
    private func generatePokemon() {
        Task {
            await vm.generatePokemon()
        }
    }
    
    private func generatePokemonLabel() -> some View {
        Text("Generate pokemon")
    }
    
    private func evolvePokemon() {
        Task {
            await vm.evolvePokemon()
        }
    }
    
    private func evolvePokemonLabel() -> some View {
        Text("Evolve pokemon")
    }
    
    private func refreshPokemon() {
        Task {
            await vm.refreshPokemon()
        }
    }
    
    private func refreshPokemonLabel() -> some View {
        Text("Refresh pokemon")
    }
    
    private var pokeInfo: some View {
        VStack {
            HStack {
                Text("Name: ")
                Text(vm.pokemonName)
            }
            HStack {
                Text("Id: ")
                Text(vm.pokemonId)
            }
            HStack {
                Text("Height")
                Text("\(vm.pokemonHeight)")
            }
            HStack {
                Text("Weight")
                Text("\(vm.pokemonWeight)")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
