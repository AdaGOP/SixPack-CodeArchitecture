//
//  Customer.swift
//  XPack2
//
//  Created by Jazilul Athoya on 09/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import Foundation

/// Modified by: Zein
/// Struct: Value type
///
/// I can implement Structures and Classes in Swift
/// https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
///
/// - Important: `TEC065    I can implement Controls with UIKit`
///


struct Customer { /// This Struct will store the value of name and email into struct Customer, which the value can be accessed and modified from anywhere as a property of Customer
    var name: String = ""
    
    /// Modified by: Zein
    /// Optional
    ///
    /// I know how to use Optional Values in Swift
    /// https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
    ///
    /// - Important: `TEC079    I know how to use Optional Values in Swift`
    ///
    var email: String? // We use an optional, according to the field that email probably empty or have no value
}
