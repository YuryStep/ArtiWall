//
//  SceneDelegate.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 19.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = HomeModuleAssembly.makeModule()
        window?.makeKeyAndVisible()
    }
}
