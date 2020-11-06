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
        
        
       // https://oauth.vk.com/authorize?client_id=7620832&display=page&redirect_uri=https://oauth.vk.com/blank.html &scope=friends&response_type=token&v=5.124&state=123456
    //    https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=ef45e4d398aee3adab88aab0e9a03cf247f12c3aad4c1b1b88ab99829effbe314a1db06030bb2ac78f225&expires_in=86400&user_id=620228374&state=123456&v=5.124
        
        
        authService = SceneDelegate.shared().authService
        super.viewDidLoad()
        signInButtonOutlet.layer.cornerRadius = 10
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    @IBAction func signInButtonPressed(_ sender: Any) {
        authService.wakeUpSession()
    }
    
}
