//
//  PokemonSet.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import Foundation

struct PokemonSet : Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonSetResult]
}

struct PokemonSetResult : Codable {
    let name: String
    let url: String
}

struct PokemonItem : Codable {
    let sprites: PokemonSprites
}

struct PokemonSprites: Codable {
    let front_shiny: String
}
