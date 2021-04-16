//
//  IngridientTableViewCell.swift
//  XPack2
//
//  Created by Jazilul Athoya on 07/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit

protocol IngridientCellProtocol: class {
    func setQuantityLabel(ingridientName: String, stepper: UIStepper) -> String
}

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
        
}
