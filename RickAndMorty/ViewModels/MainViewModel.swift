//
//  MainViewModel.swift
//  RickAndMorty
//
//  Created by Екатерина Неделько on 27.06.22.
//

import Foundation

final class MainViewModel: MainViewModelling {
    
    // MARK: - Public properties
    
    weak var view: MainViewInput?
    
    // MARK: - Private properties
    
    private let charactersService: CharactersService
    
    private var state: ViewState {
        didSet {
            self.view?.didUpdate(with: state)
        }
    }
    
    private var charactersData = [Character]()
 
    // MARK: - Initialization and deinitialization
    
    init(charactersService: CharactersService = CharactersService()) {
        self.charactersService = charactersService
        self.state = .idle
    }
}

// MARK: - DataSource

extension MainViewModel {
    var numberOfItems: Int {
        charactersData.count
    }
    
    func getCharacterInfo(for indexPath: IndexPath) -> CharacterInfo {
        let character = charactersData[indexPath.row]
        return CharacterInfo(character: character)
    }
}

// MARK: - CharactersService

extension MainViewModel {
    func loadCharacters() {
        state = .loading
        charactersService.getAllCharacters { result in
            switch result {
            case .success(let characters):
                self.charactersData = characters
                self.state = .success
            case .failure(let error):
                self.charactersData = []
                self.state = .error(error)
            }
        }
    }
}
