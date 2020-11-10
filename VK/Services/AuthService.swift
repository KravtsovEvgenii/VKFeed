//
//  AuthService.swift
//  VK
//
//  Created by User on 14.10.2020.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class{
    func authFinished()
    func vkSdkUserAuthorizationFailed()
    func vkSdkShouldPresent(_ controller: UIViewController!)
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!)
}

class AuthService: NSObject,VKSdkDelegate,VKSdkUIDelegate {
   
    private let appID = "7620832"
    private let vkSDK : VKSdk
   weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        if let tk = UserDefaults.standard.value(forKey: "token") as? String{
            return tk
        }
        return VKSdk.accessToken()?.accessToken
    }
    var userId: String? {
        if let id = UserDefaults.standard.value(forKey: "userID") as? String{
         return id
        }
        return VKSdk.accessToken()?.userId
    }
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    //Auth func
    func wakeUpSession() {
        let scope = ["wall","friends","offline"]
            
            VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
                if state == VKAuthorizationState.authorized {
                    print("VKAuthorizationState.authorized")
                    delegate?.authFinished()
                } else if state == VKAuthorizationState.initialized {
                    if self.token != nil, self.userId != nil {
                        delegate?.authFinished()
                    }else {
                    VKSdk.authorize(scope)
                    }
                } else {
                    print("auth problems, state \(state) error \(String(describing: error))")
                    delegate?.vkSdkUserAuthorizationFailed()
                }
            }
    }
    //Методы при выполнении которыъ передаем их дальнейшее выполнение делегату 
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token.accessToken != nil {
            //Для того чтобы мы не попадали на страницу подтверждения предоставления доступа к профилю храним токен и ID  в User Defaults
            UserDefaults.standard.setValue(result.token.accessToken, forKey: "token")
            UserDefaults.standard.setValue(result.token.userId, forKey: "userID")
            UserDefaults.standard.synchronize()
        delegate?.authFinished()
    }
    }
    func vkSdkUserAuthorizationFailed() {
        delegate?.vkSdkUserAuthorizationFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.vkSdkShouldPresent(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        delegate?.vkSdkNeedCaptchaEnter(captchaError)
    }
    
}



