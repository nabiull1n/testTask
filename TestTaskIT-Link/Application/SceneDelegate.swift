//
//  SceneDelegate.swift
//  TestTaskIT-Link
//
//  Created by Денис Набиуллин on 20.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

