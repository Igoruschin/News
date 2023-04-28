//
//  NewsViewController.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import UIKit

class NewsViewController: UITableViewController{
    
    private var resultsModel = [Article]()
    var factoryBuilder: DeafaultAlertsBuilder = DefaultAlertsImp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        fetch()
        
    }
    
    //MARK: - fetch APi
    func fetch() {
        NetworkManager.shared.fetchData {  result in
            switch result {
            case .success(let localModel):
                self.resultsModel = localModel.articles
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - downloadToLibrary
    private func downloadToLib(indexPath: IndexPath) {
        CDataManager.shared.downloadToCoreData(model: resultsModel[indexPath.row]) { result in
            switch result {
            case .success(): break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - config controller
    private func config() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame =  view.bounds
        tableView.register(NewsTableCell.self, forCellReuseIdentifier: NewsTableCell.id)
        tableView.separatorColor = .darkGray
        view.backgroundColor = .white.withAlphaComponent(1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Impact", size: 23) ?? ""]
        navigationController?.navigationBar.barTintColor = .white.withAlphaComponent(0.6)
        title = "News"
        
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
        return resultsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCell.id, for: indexPath)  as? NewsTableCell  else { return UITableViewCell() }
        cell.backgroundColor = .none
        let valueModel = resultsModel[indexPath.row]
        cell.setupOnCell(valueModel)
        cell.delegate = self
        cell.index = indexPath
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension NewsViewController: DelegateNewsCell{
    func add(indexPath: Int) {
        CDataManager.shared.downloadToCoreData(model: resultsModel[indexPath]) { result in
            switch result {
            case .success():
                let alert1  = self.factoryBuilder.getAlert(by: .okAlert)
                self.present(alert1, animated: true)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    self.dismiss(animated: true)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
