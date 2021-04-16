//
//  ViewController.swift
//  XPack2
//
//  Created by Jazilul Athoya on 06/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit

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

class CustomerInformationViewController: UIViewController {

    /// Modified by: Zein
    /// Input Element
    ///
    /// I know how to implement Text Input with UIKit
    /// https://developer.apple.com/documentation/uikit/text_display_and_fonts
    ///
    /// - Important: `TEC018    I know how to implement Text Views with UIKit`
    ///
    
    /// When using input element in UIKit, make sure we are aware of the keyboard interaction.
    /// Hence, UX will be take a role on that. We need to use the delegate in order to have a control of the keyboard.

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
        self.popupAlert(title: "Notice", message: "Please fill your name", actionTitles: ["Ok"], actions: nil)
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

        self.popupAlert(title: "LO's Information", message: "You need to store the name and email into the model (struct/class) in order to sync the data from anywhere. So by that all view controller will refered to one data source for the user and email. Please refer to Customer.swift", actionTitles: ["Ok"]) { (action) in
            self.performSegue(withIdentifier: "GoToBowlPage", sender: Customer(name: self.nameTextField.text! , email: self.emailTextField.text!))
        }
    }
    
}

extension CustomerInformationViewController: UITextFieldDelegate {
    /// Modified by: Zein
    /// Conditional Statement
    ///
    /// I can use Conditional Statements in Swift ( if/else; switch/case;  guard; Comparison Operators; )
    /// https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html
    ///
    /// - Important: `TEC055    I can use Conditional Statements in Swift`
    ///
    
    /// In order to make keyboard interaction smooth between text area that we have in our interface
    /// Use conditional statement to check which textfield is active and not active, and use the value to make an interaction with the keyboard

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
