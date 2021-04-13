//
//  HistoryTableViewController.swift
//  XPack2
//
//  Created by octavianus on 13/08/18.
//  Copyright © 2018 Jazilul Athoya. All rights reserved.
//

import UIKit
import CoreData


class HistoryTableViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var historyTable: UITableView!
    var allOrder: [Order]? = []
    private var dateFormat = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.fetchOrder()
    }
    
    private func setupView(){
        //Setup the view delegate / data source here
        dateFormat.dateFormat = "Y-M-d H:mm"
    }
    
    private func fetchOrder(){
       // Fetch all the order here
        let context = CoreDataHelper().objectContext()
        let orderFetch: NSFetchRequest<Order> = Order.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        orderFetch.sortDescriptors = [sortDescriptor]
        
        do{
            self.allOrder = try context.fetch(orderFetch) as [Order]?
            guard let _ = allOrder else { return }
            
        }catch{
            print("error fetching data from order")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupXPackNavigationBarFor(title: "History")
    }
    
    @IBAction func dismiss(){
        guard let sb = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {return}
        self.show(sb, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let allOrder = self.allOrder{
            return allOrder.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        
        guard
            let order = self.allOrder,
            let date = order[indexPath.row].timestamp,
            let bowlType = order[indexPath.row].bowl?.bowlType,
            let price = order[indexPath.row].bowl?.price
        else {
                return UITableViewCell()
        }
        
        cell.textLabel?.text = dateFormat.string(from: date)
        cell.detailTextLabel?.text = "\(bowlType) - \(price)"
        
        return cell
        
    }
    
    
}

