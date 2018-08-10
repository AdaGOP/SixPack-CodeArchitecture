//
//  BowlViewController.swift
//  XPack2
//
//  Created by Jazilul Athoya on 07/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit

class BowlViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bowlContentTableView: UITableView!
    @IBOutlet weak var buildInfoLabel: UILabel!
    @IBOutlet weak var bowlTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var bowlIngredients: [IngredientType] = [.base, .protein, .supplement, .topping, .dressing]
    var bowl: Bowl = Bowl()
    var customer: Customer = Customer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bowlContentTableView.delegate = self
        bowlContentTableView.dataSource = self

        bowlContentTableView.estimatedRowHeight = 60
        bowlContentTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.cyan
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 2
        
        refreshView()
    }
    
    
    // Unwind function to this controller
    @IBAction func unwindToBowlPage(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? IngridientSelectionViewController {
            
            bowl.ingredients[source.ingredientType] = source.selectedIngredients.filter{ $0.value > 0 }
            refreshView()
        }
        // Use data from the view controller which initiated the unwind segue
    }
    
    // Refresh the view so that match with the latest changes from ingredient
    func refreshView(){
        let (bowlTypeDescription, bowlTypeInfo) = bowl.getBowlTypeDetailInfo()

        bowlTypeLabel.text = "Hi \(customer.name),"
        buildInfoLabel.text = "You have \(bowlTypeDescription) bowl. \(bowlTypeInfo)"
        
        bowlContentTableView.reloadData()
        
        priceLabel.text = "\(bowl.price)K"
    }
    
    @IBAction func goToCheckoutPage(_ sender: Any) {
        performSegue(withIdentifier: "GoToCheckoutPage", sender: nil)
    }
    
    
    // Reduce or sum all value from particular type so that we get string to display
    func reduceIngridientString(type: IngredientType, ingridients: [String:Double]) -> String {
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
    
    // Function to remove decimal di belakang kalo 0
    func formatTruncateZeroPointDouble(number: Double) -> String {
        if number.rounded(.down) == number {
            return "\(Int(number))"
        } else {
            return "\(number)"
        }
    }
    

    // Prepare segue for passing value to other view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? IngridientSelectionViewController {
            let ip = sender as! IndexPath
            dest.ingredientType = bowlIngredients[ip.row]
            dest.bowl = bowl
            
            navigationController?.title = "Hai"
        }
    }
}

extension BowlViewController {
    
    // return row counts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bowlIngredients.count
    }
    
    // table view mandatory delegate, return cell to be drawn
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BowlDetailCell", for: indexPath) as! BowlDetailTableViewCell
        
        // Get the Ingredient Type
        let ingredientType = bowlIngredients[indexPath.row]
        
        cell.titleLabel.text = ingredientType.rawValue.capitalized
        
        // Check if kalo ada ingredient type then write the detail on subtitle
        if let ingridients = bowl.ingredients[ingredientType] {
            cell.subtitleLabel.text = reduceIngridientString(type: ingredientType, ingridients: ingridients)

            let sumTotal = bowl.sumTotalIngredients(type: ingredientType)
            cell.quantityLabel.text = formatTruncateZeroPointDouble(number: sumTotal)
        }
        
        return cell
    }
    
    // table view on tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "IngridientChoiceSegue", sender: indexPath)
    }
}
