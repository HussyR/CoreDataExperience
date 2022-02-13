//
//  JSONParcer.swift
//  CoreDataProject
//
//  Created by Данил on 13.02.2022.
//

import Foundation

class JSONParser {
    static let shared = JSONParser()
    private init(){};
    
    func parse() -> [CharacterModel]? {
        guard let bundle = Bundle.main.url(forResource: "seed", withExtension: "json"),
              let data = try? Data(contentsOf: bundle),
              let characters = try? JSONDecoder().decode([CharacterModel].self, from: data)
        else {return nil}
        print(characters.count)
        return characters
    }
}
