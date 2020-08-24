//
//  Country.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/24/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation

struct Country: Codable {
    #warning("Refactor data model with coding keys for better intent")
    struct Currency: Codable {
        var code: String
        var name: String
        var symbol: String
    }
//
//    struct Language: Codable {
//        var name: String
//    }

    var name: String
    var capital: String
    var population: Int
    var demonym: String // i.e. demonym of "Spain" = "Spaniard"
    var area: Int? // FIXME: this key breaks the decode
//    var timeZones: [String]
    var currencies: [Currency?] // FIXME: this key breaks the decode
//    var languages: [Language]
    var flag: String

    #warning("Add an init and coding keys to have optional keys")
    /// https://medium.com/flawless-app-stories/lets-parse-the-json-like-a-boss-with-swift-codable-protocol-3d4c4290c104
    
}

