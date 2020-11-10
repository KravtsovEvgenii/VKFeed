//
//  SceneDelegate.swift
//  VK
//
//  Created by User on 14.10.2020.
//

import UIKit
import VKSdkFramework
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?
    var authService : AuthService!

    //Scene Delegate Singleton
    static func shared()-> SceneDelegate{
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = scene?.delegate as! SceneDelegate
        return sd
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        authService = AuthService()
        authService.delegate = self
        //Устанавливаем root vc
        let authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
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
//MARK: AuthServiceDelegate
extension SceneDelegate: AuthServiceDelegate{
    func authFinished() {
        //Открываем Контроллер с лентой
        let feedVC = UIStoryboard(name: "VKFeedSB", bundle: nil).instantiateViewController(withIdentifier: "VKFeedViewController") as! VKFeedViewController
        
        let navigationVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navigationVC
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("Auth Faliled")
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        window?.rootViewController?.present(controller, animated: true, completion: nil)
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(captchaError!)
    }
    
    
}
