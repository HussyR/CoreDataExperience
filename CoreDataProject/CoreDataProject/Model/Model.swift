//
//  Model.swift
//  CoreDataProject
//
//  Created by Данил on 13.02.2022.
//

import Foundation

struct CharacterModel: Codable {
    let iD: Int
    let name: String
    let status: String
    let gender: String
    let origin: LocationModel
    let image: String
    let episode: [String]
}

struct LocationModel: Codable {
    let name: String
}
