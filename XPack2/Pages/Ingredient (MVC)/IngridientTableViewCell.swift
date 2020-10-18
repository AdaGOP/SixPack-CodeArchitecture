//
//  IngridientTableViewCell.swift
//  XPack2
//
//  Created by Jazilul Athoya on 07/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit

class IngridientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingridientStepper: UIStepper!
    @IBOutlet weak var ingridientQuantityLabel: UILabel!
    @IBOutlet weak var ingridientNameLabel: UILabel!
    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
        
    weak var cellProtocol: IngridientCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ingridientStepper.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onChangeStepperValue(_ sender: Any) {
        if let qtyLabel = cellProtocol?.setQuantityLabel(ingridientName: ingridientNameLabel.text!, stepper: ingridientStepper) {
            ingridientQuantityLabel.text = qtyLabel
        }
        
    }
    
    func cellConfig(withIngredients: [String], imageDescription: [String], currentIndex: Int, type: IngredientType, chargeAmount: Int, isCharge: Bool, selectedIng: [String:Double]) {
        applyAccessibility(imageDescription: imageDescription[currentIndex])
        let ingredientName = withIngredients[currentIndex]
        
        if let image = UIImage(named: ingredientName){
            ingredientImageView.image = image
        }
        
        if let additionalPrice = IngredientData().additionalPrice[ingredientName] {
            ingridientNameLabel.text = "\(ingredientName) (+\(additionalPrice)K)"
        } else {
            ingridientNameLabel.text = ingredientName
        }
        
        if type == .protein {
            ingridientStepper.maximumValue = 3.0
        } else {
            ingridientStepper.maximumValue = 5.0
        }
        
        if let ingridientQty = selectedIng[ingredientName] {
            ingridientStepper.value = ingridientQty
            ingridientQuantityLabel.text = getDisplayedQuantityValueFromStepper(stepperValue: ingridientQty, type: type)
        } else {
            ingridientStepper.value = 0.0
            ingridientQuantityLabel.text = "0"
        }
        
        if isCharge {
            priceLabel.text = "+\(chargeAmount)K IDR"
        } else {
            priceLabel.text = "+0K IDR"
        }
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

protocol IngridientCellProtocol: class {
    func setQuantityLabel(ingridientName: String, stepper: UIStepper) -> String
}

//MARK: Accessibility
extension IngridientTableViewCell {
    func applyAccessibility(imageDescription : String) {
        ingridientNameLabel.font = .preferredFont(forTextStyle: .body)
        ingridientNameLabel.adjustsFontForContentSizeCategory = true
        
        ingridientQuantityLabel.font = .preferredFont(forTextStyle: .body)
        ingridientQuantityLabel.adjustsFontForContentSizeCategory = true
        
        priceLabel.font = .preferredFont(forTextStyle: .body)
        priceLabel.adjustsFontForContentSizeCategory = true
        
        ingredientImageView.isAccessibilityElement = true
        ingredientImageView.accessibilityLabel = imageDescription
    }
}
