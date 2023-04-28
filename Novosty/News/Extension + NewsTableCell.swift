//
//  Extension + NewsTableCell.swift
//  News
//
//  Created by Игорь Ущин on 27.04.2023.
//

import Foundation
import UIKit

extension NewsTableCell {
    
    func images() -> UIImageView {
        let img = UIImageView().setTamic()
        img.layer.cornerRadius  = 12
        img.layer.masksToBounds = true
        return img
    }
    
   func descript() -> UILabel {
       let lbl = UILabel().setTamic()
       lbl.textAlignment = .left
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
        lbl.textAlignment = .right
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = .systemFont(ofSize: 13, weight: .medium)
        let img = UIImageView(image: UIImage(systemName: "clock")).setTamic()
        lbl.addSubview(img)
        img.centerYAnchor.constraint(equalTo: lbl.centerYAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: lbl.leadingAnchor, constant: 0).isActive = true
        img.widthAnchor.constraint(equalToConstant: 23).isActive = true
        img.heightAnchor.constraint(equalToConstant: 23).isActive = true
        img.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
         return lbl
     }
    
    func creater() -> UILabel {
        let lbl = UILabel().setTamic()
        lbl.textAlignment = .left
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.font = .systemFont(ofSize: 13, weight: .semibold)
        return lbl
     }
    
    func view() -> UIView {
        let vw = UIView().setTamic()
        vw.backgroundColor = #colorLiteral(red: 0.9341299136, green: 0.9341299136, blue: 0.9341299136, alpha: 1)
        vw.layer.cornerRadius =  15
        let img = UIImageView(image: UIImage(systemName: "pencil")).setTamic()
        vw.addSubview(img)
        img.centerYAnchor.constraint(equalTo: vw.centerYAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: vw.leadingAnchor, constant: 8).isActive = true
        img.widthAnchor.constraint(equalToConstant: 23).isActive = true
        img.heightAnchor.constraint(equalToConstant: 23).isActive = true
        img.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return vw
    }
    
    func addButton() -> UIButton {
        let btn = UIButton().setTamic()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.setImage(UIImage(systemName: "star.fill"), for: .selected)
        btn.frame.size = CGSize(width: 50, height: 50)
        btn.addTarget(self, action: #selector(Taped(sender:)), for: .touchUpInside)
        return btn
    }
    
    //MARK: - selectors
    @objc func Taped(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
           
            delegate?.add(indexPath: (index?.row)!)
            sender.isSelected = true
            
        }
    }
}
