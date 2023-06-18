//
//  ListView.swift
//  PokemonAsyncAwait
//
//  Created by Filip Bulander on 18.06.2023.
//

import SwiftUI

struct ListView: View {
    @ObservedObject private var vm = ListViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(vm.pokemons, id: \.id) { pokemon in
                    pokeInfo(pokemon: pokemon)
                }
            }
            Button(action: paralelRefresh,
                   label: paralelRefreshLabel)
            Button(action: syncRefresh,
                   label: syncRefreshLabel)
            Button(action: generateNew,
                   label: generateNewLabel)
        }
        .padding()
    }
    
    private func paralelRefresh() {
        Task {
            await vm.paralelRefresh()
        }
    }
    
    private func paralelRefreshLabel() -> some View {
        Text("Paralel refresh")
    }
    
    private func syncRefresh() {
        Task {
            await vm.synchronousRefresh()
        }
    }
    
    private func syncRefreshLabel() -> some View {
        Text("Synchronous refresh pokemon")
    }
    
    private func generateNew() {
        vm.generateNewIds()
    }
    
    private func generateNewLabel() -> some View {
        Text("Generate new Ids")
    }
    
    private func pokeInfo(pokemon: Pokemon) -> some View {
        VStack {
            AsyncImage(url: ImageUrlProvider.getUrlFrom(pokemonId: "\(pokemon.id)"))
            HStack {
                VStack {
                    HStack {
                        Text("Name: ")
                        Text(pokemon.name)
                    }
                    HStack {
                        Text("Id: ")
                        Text("\(pokemon.id)")
                    }
                }
                VStack {
                    HStack {
                        Text("Height")
                        Text("\(Int(pokemon.height))")
                    }
                    HStack {
                        Text("Weight")
                        Text("\(Int(pokemon.weight))")
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}




