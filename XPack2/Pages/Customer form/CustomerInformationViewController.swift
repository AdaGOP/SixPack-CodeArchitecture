//
//  ViewController.swift
//  XPack2
//
//  Created by Jazilul Athoya on 06/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit

class CustomerInformationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupXPackNavigationBarFor(title: "Order")
        
    }

    @IBAction func goToBowlPage(_ sender: Any) {
        
        if nameTextField.text! == "" {
            showAlertMessage()
        } else {
            showStrucClassAlertMessage()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? BowlViewController {
            dest.customer = sender as! Customer
        }
    }
    
    func showAlertMessage(){
        // create the alert
        let alert = UIAlertController(title: "Notice", message: "Please fill your name", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    func showStrucClassAlertMessage() {
        /// Modified by: Zein
        /// Struct: Value type
        ///
        /// I can implement Structures and Classes in Swift
        /// https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
        ///
        /// - Important: `TEC065    I can implement Controls with UIKit`
        ///

        // create the alert
        let alert = UIAlertController(title: "LO's Information", message: "You need to store the name and email into the model (struct/class) in order to sync the data from anywhere. So by that all view controller will refered to one data source for the user and email. Please refer to Customer.swift", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "GoToBowlPage", sender: Customer(name: self.nameTextField.text! , email: self.emailTextField.text!))
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    
}

