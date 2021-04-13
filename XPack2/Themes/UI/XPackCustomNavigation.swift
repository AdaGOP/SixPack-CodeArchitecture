//
//  ACCustomNavigation.swift
//  AYO CLEAN
//
//  Created by zein rezky chandra on 30/06/18.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func setupXPackNavigationBarFor(title: String){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                self.navigationController?.navigationBar.prefersLargeTitles = true
                let attributes = [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
                ]
                UINavigationBar.appearance().titleTextAttributes = attributes
            default:
                self.navigationController?.navigationBar.prefersLargeTitles = false
                let attributes = [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
                ]
                UINavigationBar.appearance().titleTextAttributes = attributes
            }
        }
        
        navigationController?.navigationBar.barTintColor = XPackColours.primary
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = XPackColours.lightGray
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 2
        navigationItem.title = title
        
    }
}
