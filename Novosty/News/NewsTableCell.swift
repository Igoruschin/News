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
    lazy var viewBack = view()
    
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
            
            let dat = Date()
            let format = dat.getFormattedDate(format: date ?? "yyyy-MM-dd HH:mm:ss")
        
            self.dateLabel.text = format
        
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
    //MARK: - Convert to normal date format
        func convertDataFormat(_ date: String?) -> String {
           var dateOutput = ""
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           if let dateInput = date {
               if let newDate = dateFormatter.date(from: dateInput) {
                   dateFormatter.dateFormat = "d.MM.yyyy"
                   dateOutput = dateFormatter.string(from: newDate)
               }
           }
           return dateOutput
       }

}


extension NewsTableCell {
    func setElemets() {
        separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        selectionStyle = .default
     
        
        [imagePreview,descriptionLabel,titleLabel,viewBack,dateLabel].forEach{(addSubview($0))}
        [createrLabel].forEach{(viewBack.addSubview($0))}
        
        NSLayoutConstraint.activate([
            imagePreview.centerYAnchor.constraint(equalTo: centerYAnchor),
            imagePreview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imagePreview.heightAnchor.constraint(equalToConstant: 110),
            imagePreview.widthAnchor.constraint(equalToConstant: 160),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: imagePreview.centerYAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 180),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            descriptionLabel.trailingAnchor.constraint(equalTo: imagePreview.leadingAnchor, constant: -10),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            
            viewBack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            viewBack.topAnchor.constraint(equalTo: imagePreview.bottomAnchor, constant: 10),
            viewBack.heightAnchor.constraint(equalToConstant: 30),
            viewBack.widthAnchor.constraint(equalToConstant: 130),
            
            createrLabel.trailingAnchor.constraint(equalTo: viewBack.trailingAnchor, constant: -8),
            createrLabel.centerYAnchor.constraint(equalTo: viewBack.centerYAnchor),
            createrLabel.heightAnchor.constraint(equalToConstant: 20),
            createrLabel.widthAnchor.constraint(equalToConstant: 85),

            dateLabel.centerYAnchor.constraint(equalTo: viewBack.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: 160),
            
            
                                    ])
        
    }
    
}
