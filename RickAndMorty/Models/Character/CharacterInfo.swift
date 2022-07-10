//
//  CharacterInfo.swift
//  RickAndMorty
//
//  Created by Ekaterina Nedelko on 10.07.22.
//

import Foundation

struct CharacterInfo {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let imageURL: String
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.status = CharacterStatus(rawValue: character.status) ?? .uncnown
        self.species = character.species
        self.type = character.type
        self.imageURL = character.image
    }
}
