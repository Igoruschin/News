//
//  Model.swift
//  News
//
//  Created by Игорь Ущин on 27.04.2023.
//

import Foundation

    //MARK: - Model
    struct Model: Codable {
        let articles: [Article]
    }
    
    struct Article: Codable {
        let author: String?
        let title: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
        let content: String?
    }

