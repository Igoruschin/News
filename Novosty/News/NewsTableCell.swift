//
//  NewsTableCell.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import Foundation
import UIKit

class NewsTableCell: UITableViewCell  {
    
    static let id = "NewsTableCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configCell() {
        separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        selectionStyle = .default
    }

}