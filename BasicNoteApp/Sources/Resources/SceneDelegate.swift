//
//  SceneDelegate.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 1.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Bu yöntem, UIWindow `window`'u sağlanan UIWindowScene `scene`'e isteğe bağlı olarak yapılandırmak ve bağlamak için kullanılır.
        // Bir storyboard kullanıyorsanız, `window` özelliği otomatik olarak başlatılır ve scene'e bağlanır.

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Yeni bir UIWindow oluşturun ve windowScene ile başlatın
        let window = UIWindow(windowScene: windowScene)
        
        // Kullanıcının giriş yapıp yapmadığını kontrol edin
        if UserDefaults.standard.value(forKey: "accesToken") != nil {
            // Giriş yapılmışsa, NotesScreenViewController'ı başlangıç ekranı olarak ayarlayın
            let initialViewController = NotesScreenViewController()
            let navigationController = UINavigationController(rootViewController: initialViewController)
            window.rootViewController = navigationController
        } else {
            // Giriş yapılmamışsa, RegisterViewController'ı başlangıç ekranı olarak ayarlayın
            let initialViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: initialViewController)
            window.rootViewController = navigationController
        }
        
        // UIWindow'u görünür yapın
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

