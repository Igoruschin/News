//
//  NewsViewController.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import UIKit

class NewsViewController: UITableViewController{

    private var resultsModel = [Article]()
    
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
    
    //MARK: - config controller
    private func config() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame =  view.bounds
        tableView.register(NewsTableCell.self, forCellReuseIdentifier: NewsTableCell.id)
        tableView.separatorColor = .darkGray
        view.backgroundColor = .gray.withAlphaComponent(0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Impact", size: 23) ?? ""]
        navigationController?.navigationBar.barTintColor = .gray.withAlphaComponent(0.6)
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
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
