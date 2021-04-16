//
//  BowlViewController.swift
//  XPack2
//
//  Created by Jazilul Athoya on 07/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit

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

class BowlViewController: UIViewController {
    
    @IBOutlet weak var bowlContentTableView: UITableView!
    @IBOutlet weak var buildInfoLabel: UILabel!
    @IBOutlet weak var bowlTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    /// Modified by: Zein
    /// Class: Reference type
    ///
    /// I can implement Structures and Classes in Swift
    /// https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
    ///
    /// - Important: `TEC065    I can implement Structures and Classes in Swift`
    ///

    /// First we need to create the data by creating the pre-defined data using `dataMock` function inside `Bowl.swift` which it's a`Class`.
    /// We need to define it as `Class` because we need to have a reference for it's property and modified it without make a copy of it
    
    var bowl: Bowl = Bowl.dataMock {
        didSet {
            setView(with: customer, bowl: bowl)
        }
    }
    
    
    /// Modified by: Zein
    /// Enumeration
    ///
    /// I know how to work with enumeration in Swift
    /// https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
    ///
    /// - Important: `TEC069    I know how to work with enumeration in Swift`
    ///

    /// Since we need to server Ingredient based on group of type, and each type will have the data it self. So, to make it easier, we need to make group of type into 1 single data source which store a group of related values.
    /// In Swift, we can use enumeration.
    /// Refer to IngredientType.swift
    
    // From code below we're creating an array of IngredientType, which a group of IngredientType that have properties for each.
    var bowlIngredients: [IngredientType] = IngredientType.allCases
    
    
    /// Create an instance from Customer struct
    var customer: Customer = Customer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
        showAlertMessage()
        bowlContentTableView?.delegate = self
        bowlContentTableView?.dataSource = self
        
    }
    
    func setInitialView(){
        bowlContentTableView?.estimatedRowHeight = 60
        bowlContentTableView?.rowHeight = UITableView.automaticDimension
        
        bowlTypeLabel.textColor = XPackColours.secondary
        
        self.view.backgroundColor = UIColor.white
    }
    
    func setView(with customer: Customer, bowl: Bowl){
        let (bowlTypeDescription, bowlTypeInfo) = bowl.getBowlTypeDetailInfo()
        bowlTypeLabel?.text = "Hi \(customer.name),"
        buildInfoLabel?.text = "You have *Category* as `\(bowlTypeDescription) bowl`. \(bowlTypeInfo)"
        bowlContentTableView?.reloadData()
        priceLabel?.text = "\(bowl.price)K"
    }

    func showAlertMessage(){
        self.popupAlert(title: "LO's Information", message: "At this page you'll learn how to store the Ingredients value using `struct & class` and define the category based on it using `enum`", actionTitles: ["Ok"], actions: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView(with: customer, bowl: bowl)
    }
    
    
    // Prepare segue for passing value to other view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? IngridientSelectionViewController {
            let ip = sender as! IndexPath
            dest.ingredientType = bowlIngredients[ip.row]
            dest.bowl = bowl
        }        
    }
}

extension BowlViewController: UITableViewDelegate, UITableViewDataSource {
    
    // return row counts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bowlIngredients.count
    }
    
    // table view mandatory delegate, return cell to be drawn
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BowlDetailCell", for: indexPath) as! BowlDetailTableViewCell

        cell.titleLabel.text = bowlIngredients[indexPath.row].rawValue.capitalized
        cell.subtitleLabel.text = bowl.reduceIngridientStringFor(type: bowlIngredients[indexPath.row])
        
        let bowlSummary = bowl.sumTotalIngredients(type: bowlIngredients[indexPath.row])
        cell.quantityLabel.text = NumberHelper().formatTruncateZeroPointDouble(for: bowlSummary)

        return cell
    }
    
    // table view on tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "IngridientChoiceSegue", sender: indexPath)
    }
}
