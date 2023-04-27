//
//  NetworkManager.swift
//  News
//
//  Created by Игорь Ущин on 27.04.2023.
//

import Foundation


struct Constants {
    static let apiKEY = "7d111255a241492f84be8eb3d8f3b769"
    static let baseURL = "https://newsapi.org/v2/everything?q=bitcoin&apiKey="
}

class NetworkManager {
    static let shared = NetworkManager(); private  init() {}
    
    func fetchData(completion: @escaping (Result<Model, Error>) -> ()) {
        guard let url = URL(string: Constants.baseURL + Constants.apiKEY) else { return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            DispatchQueue.main.async {
                do{
                    let modData = try decoder.decode(Model.self, from: data)
                    completion(.success(modData))
                }catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
        func fetchImage(url:URL, completion: @escaping ((Data) -> Void)) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    print("Empty Data")
                    return
                }
                DispatchQueue.main.async {
                    completion(data)
                }
            }.resume()
        }
    }


