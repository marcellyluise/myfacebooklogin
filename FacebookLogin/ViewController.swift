//
//  ViewController.swift
//  FacebookLogin
//
//  Created by Marcelly Luise Souza Godinho on 30/04/17.
//  Copyright © 2017 AIS Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if FBSDKAccessToken.current() == nil {
            
        } else {
            print(FBSDKAccessToken.current().appID)
        }
        
        setupFacebookButton()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Facebook Login
    func setupFacebookButton() {
        let facebookLoginButton = FBSDKLoginButton()
        
        facebookLoginButton.center = view.center
        facebookLoginButton.delegate = self
        
        view.addSubview(facebookLoginButton)
    }

}

extension ViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print(#function)
        print(result)
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print(#function)
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print(#function)
    }
}
