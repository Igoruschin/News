//
//  ViewController.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        setupTabBar()
    }
    
    //MARK: - add nav controllers
    private func createTabBar() {
        viewControllers = [
            createVC(vc: NewsViewController(),vcName: "News", image: "house.fill"),
            createVC(vc: FavoritesController(),vcName: "Favorites", image: "star.fill"),
           
            
            
        ]
    }
    
    //MARK: - create nav config
    private func createVC(vc: UIViewController, vcName: String, image: String) -> UINavigationController {
        let items = UITabBarItem(title: vcName,
                                 image: UIImage(systemName: image)?.withBaselineOffset(fromBottom: -10),
                                 tag: 0)
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = items
        return navController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.annimationTabBarItem(item)
    }
    
    
    //MARK: - animation for buttons
    private func annimationTabBarItem(_ item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 0.5
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.9, y: 1.9)
            
        }
        propertyAnimator.addAnimations ({ barItemView.transform = .identity}, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
    //MARK: - setup Tab bar
    private func setupTabBar() {
        let posOnX: CGFloat = 10
        let posOnY: CGFloat = 14
        let width = tabBar.bounds.width - posOnX * 2
        let height = tabBar.bounds.height + posOnY * 1
        
        let roundLayer = CAShapeLayer()
        
        let bezPath = UIBezierPath(
            roundedRect: CGRect(
                x: posOnX,
                y: view.frame.minY - 20 ,
                width: view.frame.width - 20,
                height: height),
            cornerRadius: height / 2)
        
        
        roundLayer.path = bezPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 10)
        tabBar.layer.shadowRadius = 5
        tabBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 3);
        tabBar.layer.shadowOpacity = 1
        tabBar.itemWidth = width / 6
        tabBar.itemPositioning = .centered
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        roundLayer.fillColor = UIColor.black.withAlphaComponent(0.65).cgColor
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        tabBar.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -10) })
        tabBar.items?.forEach({ $0.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Impact", size: 16) ?? ""], for: .normal)
        })
    }
    
}
