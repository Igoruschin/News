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
   
    lazy var imagePreview = images()
    lazy var descriptionLabel = descript()
    lazy var titleLabel = title()
    lazy var createrLabel = creater()
    lazy var dateLabel = date()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
        setElemets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configCell() {
        
        
    }
    
    //MARK: - setup into cell
        func setupOnCell(_ result: Article){
            update(title: result.title, descript: result.description, posterImg: result.urlToImage, creater: result.author, date: result.publishedAt)
        }

    func update(title: String?, descript: String?, posterImg: String?, creater: String?, date: String?) {
            self.createrLabel.text = creater
            self.titleLabel.text = title
            self.descriptionLabel.text = descript
            
            guard let backdropString = posterImg else {return}
            let urlString = backdropString
            
            guard let backdropImageURL = URL(string: urlString) else {
                self.imagePreview.image = UIImage(named: "notFound")
                return
            }
            self.imagePreview.image = nil
            NetworkManager.shared.fetchImage(url: backdropImageURL) { [weak self] (data: Data) in
                if let image = UIImage(data: data) {
                    self?.imagePreview.image = image
                } else {
                    self?.imagePreview.image = UIImage(named: "notFound")
                }
            }
        }

}


extension NewsTableCell {
    func setElemets() {
        separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        selectionStyle = .default
        
        [imagePreview,descriptionLabel,titleLabel,createrLabel].forEach{(addSubview($0))}
        
        NSLayoutConstraint.activate([
            imagePreview.centerYAnchor.constraint(equalTo: centerYAnchor),
            imagePreview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imagePreview.heightAnchor.constraint(equalToConstant: 100),
            imagePreview.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            descriptionLabel.leadingAnchor.constraint(equalTo: imagePreview.trailingAnchor, constant: 15),
            
            titleLabel.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            createrLabel.centerXAnchor.constraint(equalTo: imagePreview.centerXAnchor),
            createrLabel.topAnchor.constraint(equalTo: imagePreview.bottomAnchor, constant: 10),
            createrLabel.heightAnchor.constraint(equalToConstant: 16),
            createrLabel.widthAnchor.constraint(equalToConstant: 100),
            
            
                                    ])
        
    }
    
}
