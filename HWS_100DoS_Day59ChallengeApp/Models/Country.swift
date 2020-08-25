//
//  Country.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/24/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation

struct Country: Decodable {
    struct Currency: Decodable {
        var code: String
        var name: String
        var symbol: String

        private enum CurrencyCodingKeys: String, CodingKey {
            case code
            case name
            case symbol
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CurrencyCodingKeys.self)
            code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        }
    }

    struct Language: Decodable {
        var name: String

        private enum LanguageCodingKeys: String, CodingKey {
            case name
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: LanguageCodingKeys.self)
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        }
    }

    var name: String
    var capital: String
    var population: Int
    var demonym: String // i.e. demonym of "Spain" = "Spaniard"
    var area: Double
    var timezones: [String]
    var currencies: [Currency]
    var languages: [Language]
    var flagUrl: String
    
    private enum CountryCodingKeys: String, CodingKey {
        case name
        case capital
        case population
        case demonym
        case area
        case timezones
        case currencies
        case languages
        case flagUrl = "flag"
    }

    init(from decoder: Decoder) throws {
        #warning("Evaluate decoder for non optional values")
        let container = try decoder.container(keyedBy: CountryCodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        capital = try container.decodeIfPresent(String.self, forKey: .capital) ?? ""
        population = try container.decodeIfPresent(Int.self, forKey: .population) ?? -1
        demonym = try container.decodeIfPresent(String.self, forKey: .demonym) ?? ""
        area = try container.decodeIfPresent(Double.self, forKey: .area) ?? 10
        timezones = try container.decodeIfPresent([String].self, forKey: .timezones) ?? [String]()
        currencies = try container.decodeIfPresent([Currency].self, forKey: .currencies) ?? [Currency]()
        languages = try container.decodeIfPresent([Language].self, forKey: .languages) ?? [Language]()
        flagUrl = try container.decodeIfPresent(String.self, forKey: .flagUrl) ?? ""
    }
}

