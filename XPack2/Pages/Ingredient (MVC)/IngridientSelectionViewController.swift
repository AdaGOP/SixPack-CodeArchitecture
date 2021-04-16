//
//  IngridientSelectionViewController.swift
//  XPack2
//
//  Created by Jazilul Athoya on 07/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit

class IngridientSelectionViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var tableView: UITableView!

    /// Modified by: Zein
    /// Enumeration
    ///
    /// I know how to work with enumeration in Swift
    /// https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
    ///
    /// - Important: `TEC069    I know how to work with enumeration in Swift`
    ///

    /// Since IngredientType are enum, we can get the value based on it's rawValue which stored inside IngredientData
    /// Please refer to IngredientData.swift, It's `class` to store the data of each IngredientType

    var ingredientType: IngredientType = .base {
        didSet {
            switch ingredientType {
            case .base:
                ingredients = IngredientData().bases
            case .protein:
                ingredients = IngredientData().proteins
            case .supplement:
                ingredients = IngredientData().supplemets
            case .topping:
                ingredients = IngredientData().toppings
            case .dressing:
                ingredients = IngredientData().dressings
            }
        }
    }
    
    var bowl: Bowl = Bowl()
    private var selectedIngredients: [String:Double] = [:]
    private var ingredients: [String] = []
    private var isChargedForAdditionalServing = false
    private var additionalCharge = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        if bowl.ingredients[ingredientType] != nil {
            selectedIngredients = bowl.ingredients[ingredientType]!
        }
        
        updatePriceBarItem(price: bowl.price)
        
        (isChargedForAdditionalServing, additionalCharge) = bowl.isChargedForAdditionalServing(type: ingredientType)
    }
    
    func updatePriceBarItem(price: Int){
        priceLabel?.text = "\(price)"
    }
    
    func setupView() {
        self.view.backgroundColor = .white
    }
    
    func getDisplayedQuantityValueFromStepper(stepperValue: Double, type: IngredientType) -> String {
        if type == .protein {
            if stepperValue == 1.0 {
                return "0.5"
            } else if stepperValue > 1 {
                return "\(Int(stepperValue - 1))"
            }
        }
        return "\(Int(stepperValue))"
    }
    
}

// MARK:- Table View Cell Base Protocol
extension IngridientSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngridientCell", for: indexPath) as! IngridientTableViewCell
        let ingredientName = ingredients[indexPath.row]
        
        if let image = UIImage(named: ingredientName){
            cell.ingredientImageView.image = image
        }
        
        if let additionalPrice = IngredientData().additionalPrice[ingredientName] {
            cell.ingridientNameLabel.text = "\(ingredientName) (+\(additionalPrice)K)"
        } else {
            cell.ingridientNameLabel.text = ingredientName
        }
        
        if ingredientType == .protein {
            cell.ingridientStepper.maximumValue = 3.0
        } else {
            cell.ingridientStepper.maximumValue = 5.0
        }
        
        if let ingridientQty = selectedIngredients[ingredientName] {
            cell.ingridientStepper.value = ingridientQty
            cell.ingridientQuantityLabel.text = getDisplayedQuantityValueFromStepper(stepperValue: ingridientQty, type: ingredientType)
        } else {
            cell.ingridientStepper.value = 0.0
            cell.ingridientQuantityLabel.text = "0"
        }
        
        if isChargedForAdditionalServing {
            cell.priceLabel.text = "+\(self.additionalCharge)K IDR"
        } else {
            cell.priceLabel.text = "+0K IDR"
        }
        
        cell.cellProtocol = self
        
        return cell
    }
}


// MARK:- Table View Cell Ingredient Protocol
extension IngridientSelectionViewController: IngridientCellProtocol {
    // return value to be displayed in the cell
    func setQuantityLabel(ingridientName: String, stepper: UIStepper) -> String {
        self.popupAlert(title: "Notice", message: "When you change the value of it's quantity, it will update the value of \(ingridientName) in the Array, and use it's value to calculate price at the bottom.", actionTitles: ["Ok"]) { (action) in
            self.selectedIngredients[ingridientName] = stepper.value
            self.bowl.ingredients[self.ingredientType] = self.selectedIngredients
            self.updatePriceBarItem(price: self.bowl.price)
            
            let (isCharged, chargeAmount) = self.bowl.isChargedForAdditionalServing(type: self.ingredientType)
            if isCharged != self.isChargedForAdditionalServing {
                self.isChargedForAdditionalServing = isCharged
                self.additionalCharge = chargeAmount
                self.tableView?.reloadData()
            }
        }
        
        return getDisplayedQuantityValueFromStepper(value: stepper.value,for: ingredientType)
    }
}



// MARK:- Page Business Logic - This is Testable
extension IngridientSelectionViewController {
    /// Modified by: Zein
    /// Conditional Statement
    ///
    /// I can use Conditional Statements in Swift ( if/else; switch/case;  guard; Comparison Operators; )
    /// https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html
    ///
    /// - Important: `TEC055    I can use Conditional Statements in Swift`
    ///
    
    /// Use conditional statement to check which IngredientType is and return the value
    
    func getDisplayedQuantityValueFromStepper(value: Double,for ingredientType: IngredientType) -> String {
        if ingredientType == .protein {
            if value == 1.0 {
                return "0.5"
            } else if value > 1 {
                return "\(Int(value - 1))"
            }
        }
        return "\(Int(value))"
    }
}
