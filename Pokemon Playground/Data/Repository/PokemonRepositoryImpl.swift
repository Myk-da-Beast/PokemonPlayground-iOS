//
//  PokemonRepositoryImpl.swift
//  Pokemon Playground
//
//  Created by Michael Vance on 11/7/20.
//

import Foundation

class PokemonRepositoryImpl {
    private static let BASE_URL = "https://pokeapi.co/api/v2/"
    private let GET_POKEMON_URL = URL(string: BASE_URL + "pokemon/")!
    
    func getPokemon(_ completionHandler: @escaping ([PokemonRemoteModel]) -> Void) {
        let task = URLSession.shared.dataTask(with: GET_POKEMON_URL, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error fetching pokemon: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data, let response = try? JSONDecoder().decode(PokemonListResponse.self, from: data) {
                completionHandler(response.results)
            }
            
        })
        task.resume()
    }
}
