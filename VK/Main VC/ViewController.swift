//
//  ViewController.swift
//  VK
//
//  Created by User on 14.10.2020.
//

import UIKit
import VKSdkFramework

class ViewController: UIViewController {
    var authService: AuthService!
    

    @IBOutlet weak var signInButtonOutlet: UIButton!
    override func viewDidLoad() {
        authService = SceneDelegate.shared().authService
        super.viewDidLoad()
        signInButtonOutlet.layer.cornerRadius = 10
        
    }
    @IBAction func signInButtonPressed(_ sender: Any) {
        authService.wakeUpSession()
    }
}
