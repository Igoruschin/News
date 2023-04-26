//
//  SceneDelegate.swift
//  Novosty
//
//  Created by Игорь Ущин on 26.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
        let navigation = UINavigationController(rootViewController: MainTabViewController())
        let window  = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        window.rootViewController = navigation
        self.window = window
        
    }



}

