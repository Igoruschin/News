//
//  Extension + NewsTableCell.swift
//  News
//
//  Created by Игорь Ущин on 27.04.2023.
//

import Foundation
import UIKit

extension NewsTableCell  {
    
    func images() -> UIImageView {
        let img = UIImageView().setTamic()
        img.layer.cornerRadius  = 100/2
        img.layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        img.layer.borderWidth = 2.2
        img.layer.masksToBounds = true
        return img
    }
    
   func descript() -> UILabel {
        let lbl = UILabel().setTamic()
       lbl.textAlignment = .center
       lbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
       lbl.numberOfLines = 6
       lbl.font = .systemFont(ofSize: 12, weight: .medium)
        return lbl
    }
    
    func title() -> UILabel {
         let lbl = UILabel().setTamic()
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
         return lbl
     }
    
    func date() -> UILabel {
         let lbl = UILabel().setTamic()
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
         return lbl
     }
    
    func creater() -> UILabel {
         let lbl = UILabel().setTamic()
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
         return lbl
     }
}
