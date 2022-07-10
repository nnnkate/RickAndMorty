//
//  Character.swift
//  RickAndMorty
//
//  Created by Екатерина Неделько on 23.06.22.
//

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let image: String
    let location: Location
    let episode: [String]
}

struct Location: Codable {
    let name: String
    let url: String
}

