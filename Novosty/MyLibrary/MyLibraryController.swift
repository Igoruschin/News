//
//  MyLibraryController.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import UIKit

class MyLibraryController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
    }
    
    private func config() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame =  view.bounds
        tableView.backgroundColor = .green
        tableView.register(LibraryTableCell.self, forCellReuseIdentifier: LibraryTableCell.id)
        view.backgroundColor = .gray.withAlphaComponent(0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Impact", size: 23) ?? ""]
        navigationController?.navigationBar.barTintColor = .gray.withAlphaComponent(0.6)
        title = "Library"
        
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
    
    //MARK: - table view config
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableCell.id, for: indexPath) as? LibraryTableCell  else { return UITableViewCell() }
        cell.backgroundColor = .systemGray
        cell.textLabel?.text = "op"
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
