//
//  PokemonListResponse.swift
//  Pokemon Playground
//
//  Created by Michael Vance on 11/8/20.
//

import Foundation

struct PokemonListResponse: Codable {
    var results: [PokemonRemoteModel]
}
