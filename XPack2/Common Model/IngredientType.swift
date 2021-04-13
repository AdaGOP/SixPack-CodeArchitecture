//
//  IngredientType.swift
//  XPack2
//
//  Created by octavianus on 06/10/20.
//  Copyright © 2020 Jazilul Athoya. All rights reserved.
//

import Foundation

/// Modified by: Zein
/// Enumeration
///
/// I know how to work with enumeration in Swift
/// https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
///
/// - Important: `TEC069    I know how to work with enumeration in Swift`
///

/// Aditional knowledge from here `CaseIterable`
/// We use it, in order to access all values inside `IngredientType` enum and return it to View

enum IngredientType: String, CaseIterable {
    case base, protein, supplement, topping, dressing
}
