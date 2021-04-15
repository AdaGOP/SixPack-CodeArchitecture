//
//  BowlView.swift
//  XPack2
//
//  Created by Haryanto Salim on 07/10/20.
//  Copyright © 2020 Jazilul Athoya. All rights reserved.
//

import UIKit

class BowlView: UIView {
    
    @IBOutlet weak var bowlContentTableView: UITableView!
    @IBOutlet weak var buildInfoLabel: UILabel!
    @IBOutlet weak var bowlTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setInitialView()
    }
    
    private func setInitialView(){
        bowlContentTableView?.estimatedRowHeight = 60
        bowlContentTableView?.rowHeight = UITableView.automaticDimension
        
        bowlTypeLabel.textColor = XPackColours.secondary
        
        self.backgroundColor = UIColor.white
    }
    
    public func setView(with customer: Customer, bowl: Bowl){
        let (bowlTypeDescription, bowlTypeInfo) = bowl.getBowlTypeDetailInfo()
        bowlTypeLabel?.text = "Hi \(customer.name),"
        buildInfoLabel?.text = "You have *Category* as `\(bowlTypeDescription) bowl`. \(bowlTypeInfo)"
        bowlContentTableView?.reloadData()
        priceLabel?.text = "\(bowl.price)K"
    }
    
}
