//
//  Country.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/24/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var population: Int
    var demonym: String // i.e. demonym of "Spain" = "Spaniard"
    var area: Int
    var timeZones: [String]
    var currency: [Currency]
    var languages: [Language]
    var flagURL: String
}
