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
        return VKSdk.accessToken()?.accessToken
    }
    var userId: String? {
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
        let scope = ["wall","friends"]//,"friends","wall","photos","audio","video","groups"]
        VKSdk.wakeUpSession(scope) { [delegate](authStatus, error) in
//            if authStatus == VKAuthorizationState.authorized {
//                print("VKAuthorizationState.authorized")
//                delegate?.authFinished()
//            } else if authStatus == VKAuthorizationState.initialized {
//                print("VKAuthorizationState.initialized")
//                VKSdk.authorize(scope)
//            } else {
//                print("auth problems, state \(authStatus) error \(String(describing: error))")
//                delegate?.vkSdkUserAuthorizationFailed()
//            }
            
            switch authStatus {
            case .authorized:
                print("aut")
                delegate?.authFinished()

            case .initialized:
                VKSdk.authorize(scope)

                print("ini")//Вызовет VK Should present
            case .error:
                print(error!.localizedDescription)
            case .external:
                print("ext")
            case .pending:
                print("pending")
            case .safariInApp:
                print("safariInApp")
            case .webview:
                print("webview")
            case .unknown:
                VKSdk.authorize(scope)
                print("unknown")
            @unknown default:
                print("default")
            }
            
        }
    }

    //Методы при выполнении которыъ передаем их дальнейшее выполнение делегату 
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
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
