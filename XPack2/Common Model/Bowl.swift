//
//  Bowl.swift
//  XPack2
//
//  Created by Jazilul Athoya on 07/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import Foundation

public class Bowl: NSObject, NSCoding {

    var ingredients: [IngredientType: [String:Double] ]  = [:]
    
    override init(){
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        var temp = [String:[String:Double]]()
        for (key, value) in ingredients {
            
            temp[key.rawValue] = value
        }
        
        aCoder.encode(temp, forKey: "ingredients")
    }
    
    public required init?(coder aDecoder: NSCoder) {

        //Works
        guard let tempData = aDecoder.decodeObject(forKey: "ingredients") as? [String:[String:Double]] else {return }

        //return it to enum
        var tempResult = [IngredientType:[String:Double]]()
        for (key, value) in tempData {
            tempResult[IngredientType(rawValue: key)!] = value
        }
        
        self.ingredients = tempResult
        
    }
}

// Add business case functionality
extension Bowl{
    
    // Computed variable, bowl type depend on how many protein quantity
    var bowlType: BowlType {
        get {
            guard let protein = ingredients[.protein] else {
                    return .petite
            }
            
            var proteinQuantity = 0.0
            
            for (_,value) in protein {
                proteinQuantity = value
            }
            
            switch proteinQuantity {
            case 0...1:
                return .petite
            case 1...2:
                return .regular
            default:
                return .large
            }
        }
    }
    
    // Computed variable, price depend on bowl and additional type
    var price: Int {
        get {
            var finalPrice = 0
            let ingredientData = IngredientData()
            var ingredientCounts: [IngredientType:Double] = [
                .base: 0,
                .protein: 0,
                .supplement: 0,
                .topping: 0,
                .dressing: 0,
            ]
            let ingredientBase: [IngredientType:Double] = getIngredientBaseForBowlType()
            
            // calculate if there any item with additional price, and count how many item on each ingredient type
            for (bowlKey, bowlValue) in ingredients {
                ingredientCounts[bowlKey] = 0
                for (ingKey, ingValue) in bowlValue {
                    ingredientCounts[bowlKey]! += ingValue
                    if ingValue > 0 {
                        if let ing = ingredientData.additionalPrice[ingKey] {
                            finalPrice += ing
                        }
                    }
                }
            }
            
            // check type from base and calculate the additional fee
            for (bowlKey, bowlValue) in ingredientCounts{
                let diff = bowlValue - ingredientBase[bowlKey]!
                if diff > 0 {
                    if bowlKey == .base ||  bowlKey == .supplement {
                        finalPrice += Int(diff) * 10
                    } else if bowlKey == .topping || bowlKey == .dressing {
                        finalPrice += Int(diff) * 5
                    }
                }
            }
            
            return finalPrice + bowlType.rawValue
        }
    }
    
    // total sum ingredient for each type
    func sumTotalIngredients(type: IngredientType) -> Double {
        var count = 0.0
        for ingridient in ingredients[type]! {
            if type == .protein {
                if ingridient.value == 1.0 {
                    count += 0.5
                } else if ingridient.value > 1 {
                    count += (ingridient.value - 1)
                }
            } else {
                count += ingridient.value
            }
        }
        return count
    }
    
    // Calculate addtional serving
    func isChargedForAdditionalServing(type: IngredientType) -> (Bool, Int) {
        
        let ingredientBase = getIngredientBaseForBowlType()
        var count = 0
        
        if let ingredientTemp = ingredients[type] {
            for ingredient in ingredientTemp {
                count += Int(ingredient.value)
            }
        }
        
        if count - Int(ingredientBase[type]!) >= 0 {
            if type == .base || type == .supplement {
                return (true, 10)
            } else if type == .dressing || type == .topping {
                return (true, 5)
            }
        }
        
        return (false, 0)
    }
    
    // Dapetin info bowl nya kalo petite apa dll
    func getBowlTypeDetailInfo() -> (String,String) {
        if bowlType == .petite {
            return ("Petite", "You can have 1/2 protein, 2 supplements and 1 each others")
        } else if bowlType == .regular {
            return ("Regular", "You can have 1 protein, 3 supplements and 1 each others")
        } else if bowlType == .large {
            return ("Large", "You can have 2 protein, 3 supplements and 1 each others")
        }
        
        return ("","")
    }
    
    // Reduce or sum all value from particular type so that we get string to display
    func reduceIngridientStringFor(type: IngredientType) -> String {
        let ingridients = self.ingredients[type]!
        var tempString = ""
        var count = 0
        for ingridient in ingridients {
            count += 1
            if ingridient.value > 0.0 {
                if type == .protein {
                    if ingridient.value == 1.0 {
                        tempString.append("1/2 \(ingridient.key)")
                    } else {
                        tempString.append("\(Int(ingridient.value) - 1) \(ingridient.key)")
                    }
                } else {
                    tempString.append("\(Int(ingridient.value)) \(ingridient.key)")
                }
                
                if count < ingridients.count {
                    tempString.append(", ")
                }
            }
        }
        
        if tempString == "" {
            tempString = "Please pick your best choice"
        }
        return tempString
    }
    
    // dapetin base buat bowl berdasarkan type bowlnya
    func getIngredientBaseForBowlType() -> [IngredientType:Double] {
        var ingredientBase: [IngredientType:Double] = [
            .base: 1,
            .protein: 1,
            .supplement: 2,
            .topping: 1,
            .dressing: 1,
            ]
        
        if bowlType == .regular {
            ingredientBase[.protein] = 2
            ingredientBase[.supplement] = 3
        } else if bowlType == .large {
            ingredientBase[.protein] = 3
            ingredientBase[.supplement] = 3
        }
        
        return ingredientBase
    }
}


extension Bowl {
    
    /// Modified by: Zein
    /// Dictionary: Collection
    ///
    /// I can effectively use Collection Types in Swift
    /// Since each Ingredients
    /// https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
    ///
    /// - Important: `TEC072    I can effectively use Collection Types in Swift`
    ///

    
    static var dataMock: Bowl = {
        let bowl = Bowl()
        bowl.ingredients[IngredientType.base] = ["Brown Rice": 0.0, "Romaine Lettuce": 0.0, "Sweet Potato": 0.0, "Whole-wheat Pasta": 1.0, "Baby Spinach": 0.0, "Quinoa": 0.0]
        bowl.ingredients[IngredientType.protein] = ["Chicken Breast": 1.0, "Dory": 0.0, "Tilapia": 0.0, "Tofu": 0.0, "Rib Eye Steak": 0.0, "Salmon": 1.0]
        bowl.ingredients[IngredientType.supplement] = ["Baby Corn": 1.0, "Bell Papers": 0.0, "Broccoli": 1.0, "Butter Bean": 1.0, "Button Mushrooms": 0.0, "Carrots": 1.0, "Cherry Tomatoes": 0.0, "Couscous": 0.0, "Egg Whites": 0.0, "Kimchi": 0.0, "Onsen Egg": 0.0, "Pumpkin": 0.0, "Spicy Edamame": 0.0, "Sweet Corn": 0.0, "Wakame": 1.0, "Zucchini": 1.0, "Avocado": 1.0]
        bowl.ingredients[IngredientType.topping] = ["Almonds": 1.0, "Furikake": 0.0, "Garlic": 0.0, "Mixed Seeds": 1.0, "Raisins": 0.0, "Tortilla": 0.0]
        bowl.ingredients[IngredientType.dressing] = ["Barbeque": 1.0, "Green Curry": 1.0, "Mint Yogurt": 1.0, "Miso Mustard": 0.0, "Pesto Vinaigrette": 0.0, "Romesco": 0.0, "Sesame Peanut": 0.0, "Thai": 0.0]
        return bowl
    }()
}
