//
//  NetworkManager.swift
//  RMparsing
//
//  Created by Антон Заричный on 22.09.2022.
//

import Foundation
import Alamofire

enum RickInfo: String, CaseIterable {
    case firstPage = "https://rickandmortyapi.com/api/character?name=rick"
    case secondPage = "https://rickandmortyapi.com/api/character?page=2&name=rick"
    case thirdPage = "https://rickandmortyapi.com/api/character?page=3&name=rick"
    case fourthPage = "https://rickandmortyapi.com/api/character?page=4&name=rick"
    case fifthPage = "https://rickandmortyapi.com/api/character?page=5&name=rick"
    case sixthPage = "https://rickandmortyapi.com/api/character?page=6&name=rick"
}

enum MortyInfo: String, CaseIterable {
    case firstPage = "https://rickandmortyapi.com/api/character?name=morty"
    case secondPage = "https://rickandmortyapi.com/api/character?page=2&name=morty"
    case thirdPage = "https://rickandmortyapi.com/api/character?page=3&name=morty"
    case fourthPage = "https://rickandmortyapi.com/api/character?page=4&name=morty"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchInfoAF(url: String, completion: @escaping([Character]) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let characters = Character.getCharacters(from: value)
                    completion(characters)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchImages(urlImage: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: urlImage) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
