//
//  AlertsBuilder.swift
//  News
//
//  Created by Игорь Ущин on 28.04.2023.
//

import Foundation
import UIKit

enum DefaultsAlert {
    case okAlert
    case delAlert

}

protocol DeafaultAlertsBuilder: AnyObject {
    func getAlert(by type: DefaultsAlert) -> UIViewController
}

class DefaultAlertsImp: DeafaultAlertsBuilder {
    
  
    func getAlert(by type: DefaultsAlert) -> UIViewController {
        switch type {
        case .okAlert     : return alertComplete()
            
        case .delAlert    : return alertDelete()
            
        }
    }
    
    func  alertComplete() -> UIViewController {
        let alertController = UIAlertController(title: nil, message: "You have added news to favorites 😜", preferredStyle: .alert)
        return alertController
    }

    func  alertDelete() -> UIViewController {
        let alertController = UIAlertController(title: nil, message: "You have removed the news from your favorites 🥱", preferredStyle: .alert)
        return alertController
    }
}
