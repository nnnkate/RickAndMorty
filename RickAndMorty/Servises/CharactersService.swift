//
//  CharactersService.swift
//  RickAndMorty
//
//  Created by Екатерина Неделько on 23.06.22.
//

import Foundation

fileprivate enum CharactersLink {
    case link(scheme: String, host: String, path: String)
    
    static let allCharactersLink: CharactersLink = .link(scheme: CharactersService.scheme,
                                                         host: CharactersService.host,
                                                         path: "/api/character")
}

protocol CharactersServiceProtocol {
    func getAllCharacters(completion: @escaping (Result<[Character], Error>) -> ())
}

class CharactersService {
    
    fileprivate static let scheme = "https"
    fileprivate static let host = "rickandmortyapi.com"
    
    private func buildURL(from link: CharactersLink) -> URL? {
        switch link {
        case .link(let scheme, let host, let path):
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            
            return components.url
        }
    }
    
    private func fetchData(from link: CharactersLink, completion: @escaping (Data?, Error?) -> ()) {
        guard let url = buildURL(from: link) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let session = URLSession(configuration: .default)

        let dataTask = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
}

// MARK: - API

extension CharactersService: CharactersServiceProtocol {
    func getAllCharacters(completion: @escaping (Result<[Character], Error>) -> ()) {
        fetchData(from: CharactersLink.allCharactersLink) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let charactersResponse = try decoder.decode(CharactersResponse.self, from: data)
                completion(.success(charactersResponse.results))
            }
            catch let error {
                completion(.failure(error))
            }
        }
    }
}

