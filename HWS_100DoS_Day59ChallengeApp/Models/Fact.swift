//
//  Fact.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/25/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation

#warning("implement a flat structure for the detail view's tableview")
struct Fact {
    var name: String
    var data: Any
}

enum DefinedFacts: CaseIterable {
    #warning("Implement the remaining cases -- if this solution works")
    case name
    case capital
    case population
    case demonym
    case area
    case timezones
    case currencyCode
    case currencyName
    case currencySymbol
    case languageName
}
