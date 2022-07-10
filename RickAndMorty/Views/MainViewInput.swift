//
//  MainViewInput.swift
//  RickAndMorty
//
//  Created by Ekaterina Nedelko on 10.07.22.
//

import Foundation

protocol MainViewInput: AnyObject {
    func didUpdate(with state: ViewState)
}
