//
//  AlertMessageHelper.swift
//  XPack2
//
//  Created by zein rezky chandra on 13/04/21.
//  Copyright © 2021 Jazilul Athoya. All rights reserved.
//

import UIKit

extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitles[0], style: .default, handler: actions)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
