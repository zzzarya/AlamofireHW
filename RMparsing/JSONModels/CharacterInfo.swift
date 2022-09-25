//
//  RickInfo.swift
//  RMparsing
//
//  Created by Антон Заричный on 19.09.2022.
//

import Foundation

struct Results: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String?
    let image: String?
    
    init(characterInfo: [String: Any]) {
    name = characterInfo["name"] as? String ?? ""
    image = characterInfo["image"] as? String ?? ""
    }
}

extension Character {
    static func getCharacters(from value: Any) -> [Character] {
        var characters = [Character]()
        
        guard let resultsInfo = value as? [String: Any] else { return [] }
        guard let charactersInfo = resultsInfo["results"] as? [[String: Any]] else { return [] }
        for characterInfo in charactersInfo {
            let character = Character(characterInfo: characterInfo)
            characters.append(character)
        }
        return characters
    }
}
