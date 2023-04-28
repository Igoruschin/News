//
//  NewsTableCell.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import Foundation
import UIKit

protocol DelegateNewsCell {
    func add(indexPath: Int)
}

final class NewsTableCell: UITableViewCell  {
    
    static let id = "NewsTableCell"
    var delegate: DelegateNewsCell?
    var index : IndexPath?
    
    
    private var resultsModel = [Article]()
    
    lazy var imagePreview = images()
    lazy var descriptionLabel = descript()
    lazy var titleLabel = title()
    lazy var createrLabel = creater()
    lazy var dateLabel = date()
    lazy var viewBack = view()
    lazy var button = addButton()
    
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
            self.createrLabel.text = creater ?? "Anonymous author"
            self.titleLabel.text = title
            self.descriptionLabel.text = descript
            
            let dat = Date()
            let format = dat.getFormattedDate(format: date ?? "Empty date")
        
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

}

//MARK: - set constraints
extension NewsTableCell {
    func setElemets() {
        separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        selectionStyle = .default
     
        [imagePreview,descriptionLabel,titleLabel,viewBack,dateLabel,button].forEach{(contentView.addSubview($0))}
        [createrLabel].forEach{(viewBack.addSubview($0))}
        
        NSLayoutConstraint.activate([
            imagePreview.centerYAnchor.constraint(equalTo: centerYAnchor),
            imagePreview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imagePreview.heightAnchor.constraint(equalToConstant: 110),
            imagePreview.widthAnchor.constraint(equalToConstant: 160),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 35),
            button.widthAnchor.constraint(equalToConstant: 35),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: imagePreview.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            descriptionLabel.trailingAnchor.constraint(equalTo: imagePreview.leadingAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
            
            viewBack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            viewBack.topAnchor.constraint(equalTo: imagePreview.bottomAnchor, constant: 10),
            viewBack.trailingAnchor.constraint(equalTo: imagePreview.leadingAnchor, constant: -10),
            viewBack.heightAnchor.constraint(equalToConstant: 30),
            
            
            createrLabel.trailingAnchor.constraint(equalTo: viewBack.trailingAnchor, constant: -8),
            createrLabel.centerYAnchor.constraint(equalTo: viewBack.centerYAnchor),
            createrLabel.heightAnchor.constraint(equalToConstant: 20),
            createrLabel.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 36),

            dateLabel.centerYAnchor.constraint(equalTo: viewBack.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: imagePreview.leadingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: 155),
            
           
                                    ])
        
    }
    
}
