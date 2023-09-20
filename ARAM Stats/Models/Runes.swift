//
//  Runes.swift
//  ARAM Stats
//
//  Created by Andrew Mo on 9/19/23.
//

import Foundation

struct Runes: Decodable {
    var id: Int
    var icon: String
    var slots: [Slots]
}

struct Slots: Decodable {
    var runes: [Rune]
}

struct Rune: Decodable {
    var id: Int
    var icon: String
}
