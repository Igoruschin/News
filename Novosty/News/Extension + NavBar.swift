//
//  Extension + NavBar.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import Foundation
import UIKit

extension UITableViewController {
    
    func addCustomNavView( titleController: String, userImage: String) -> UIView {

        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: navigationController?.navigationBar.frame.height ?? 100)
    
        let imageTitle = UIImageView(image: UIImage(systemName: userImage))
        imageTitle.frame = CGRect(x: 45, y: 5, width: 30, height: 37)
        imageTitle.tintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        view.addSubview(imageTitle)
        
        let titleViewLabel =  UILabel()
            titleViewLabel.text = titleController
        titleViewLabel.frame = CGRect(x: view.frame.midX - 30, y: 0, width: 140, height: 30)
            let strokeTextAttributes = [
                NSAttributedString.Key.strokeColor : UIColor.white.withAlphaComponent(0.7),
              NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1),
              NSAttributedString.Key.strokeWidth : -1.7,
              NSAttributedString.Key.font : UIFont(name: "Impact", size: 29)!]
              as [NSAttributedString.Key : Any]
            titleViewLabel.attributedText = NSMutableAttributedString(string: "News", attributes: strokeTextAttributes)
            view.addSubview(titleViewLabel)
        
        return view
    }
    
}
