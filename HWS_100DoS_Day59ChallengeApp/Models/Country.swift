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
    var area: Int // FIXME: this key breaks the decode
//    var timeZones: [String]
    var currencies: [Currency] // FIXME: this key breaks the decode
//    var languages: [Language]
    var flag: String

    #warning("Add an init and coding keys to have optional keys")
    /// https://medium.com/flawless-app-stories/lets-parse-the-json-like-a-boss-with-swift-codable-protocol-3d4c4290c104
    private enum CodingKeys: String, CodingKey {
        case name
        case capital
        case population
        case demonym
        case area
//        case timeZones
        case currencies
        case languages
        case flagUrl = "flag"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        capital = try container.decode(String.self, forKey: .capital)
        population = try container.decode(Int.self, forKey: .population)
        demonym = try container.decode(String.self, forKey: .demonym)
        area = try container.decodeIfPresent(Int.self, forKey: .area) ?? -1
        currencies = try container.decodeIfPresent([Currency].self, forKey: .currencies) ?? [Currency]()
        flag = try container.decode(String.self, forKey: .flagUrl)
    }
}

