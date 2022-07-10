//
//  ViewState.swift
//  RickAndMorty
//
//  Created by Ekaterina Nedelko on 10.07.22.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
