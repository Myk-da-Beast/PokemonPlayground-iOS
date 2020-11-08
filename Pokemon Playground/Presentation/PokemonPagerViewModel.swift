//
//  PokemonPagerViewModel.swift
//  Pokemon Playground
//
//  Created by Michael Vance on 11/7/20.
//

import Foundation
import Combine

class PokemonPagerViewModel: ObservableObject {
    @Published private(set) var pokemon: [PokemonDomainModel] = []
    
    var didChange = PassthroughSubject<PokemonPagerViewModel, Never>()
    let pokemonRepository: PokemonRepositoryImpl
    
    init(repository: PokemonRepositoryImpl) {
        pokemonRepository = repository
    }
    
    func getPokemon() {
        pokemonRepository.getPokemon { [weak self ](results) in
            DispatchQueue.main.async {
                self?.pokemon = results.map({
                    let id: Int = Int($0.url.dropLast().components(separatedBy: "/").last ?? "0") ?? 0
                    return PokemonDomainModel(id: id, name: $0.name, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
                })
            }
        }
    }
}
