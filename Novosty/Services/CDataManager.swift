//
//  CDataManager.swift
//  News
//
//  Created by Игорь Ущин on 28.04.2023.
//
import Foundation
import UIKit
import CoreData

class CDataManager {
    
    static let shared = CDataManager(); private init() {}
    
    enum DataError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }

    func downloadToCoreData(model: Article, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let item = CDataModel(context: context)
    
        item.title = model.title
        item.date = model.publishedAt
        item.author = model.author
        item.content = model.content
        item.descript = model.description
        item.url = model.url
        item.imageUrl = model.urlToImage
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataError.failedToSaveData))
        }
    }

    
    func fetchFromCoreData(completion: @escaping (Result<[CDataModel], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<CDataModel>
        request = CDataModel.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DataError.failedToFetchData))
        }
    }

    
    func removeFromCoreData(model: CDataModel, completion: @escaping (Result<Void, Error>)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataError.failedToDeleteData))
        }
    }
}
