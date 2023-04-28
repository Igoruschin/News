//
//  FavoriteController.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import UIKit

class FavoritesController: UITableViewController{
   
    private var results = [CDataModel]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
    }
    
    //MARK: - fetch from CoreData
    func fetchData() {
        CDataManager.shared.fetchFromCoreData { [weak self] result in
            switch result {
            case .success(let films):
                self?.results = films
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - remove from database
    private func removeFromCoreData(indexPath: IndexPath) {
        CDataManager.shared.removeFromCoreData(model: results[indexPath.row]) { [weak self] entity in
            switch entity {
            case .success(): break
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.results.remove(at: indexPath.row)
            self?.tableView.deleteRows( at: [indexPath], with: .fade)
        }
    }
    
    private func config() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame =  view.bounds
        tableView.backgroundColor = .green
        tableView.register(FavoriteTableCell.self, forCellReuseIdentifier: FavoriteTableCell.id)
        view.backgroundColor = .gray.withAlphaComponent(0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Impact", size: 23) ?? ""]
        navigationController?.navigationBar.barTintColor = .gray.withAlphaComponent(0.6)
        title = "Favorites"
        
    }
    
    //MARK: - hide,uinhide navigation bar
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }, completion: nil)
        }
    }
    
    //MARK: - table View Config
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableCell.id, for: indexPath)  as? FavoriteTableCell  else { return UITableViewCell() }
        cell.backgroundColor = .none
        let coreModel = results[indexPath.row]
        cell.setupOnCell(coreModel)
        cell.delegate = self
        cell.index = indexPath
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.removeFromCoreData(indexPath: indexPath)
        }
    }
}

extension FavoritesController: DelegateFavoriteCell{
    func delete(indexPath: Int) {
        CDataManager.shared.removeFromCoreData(model: results[indexPath]) { [weak self] result in
               switch result {
               case .success():
                   self?.results.remove(at: indexPath)
                   self?.tableView.reloadData()
               case .failure(let error):
                   print(error.localizedDescription)
            }
        }
    }
}
