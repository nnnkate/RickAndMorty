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
    let status: String
    let species: String
    let type: String
    let imageURL: String
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.type = character.type
        self.imageURL = character.image
    }
}
