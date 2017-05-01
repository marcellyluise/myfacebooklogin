//
//  ViewController.swift
//  FacebookLogin
//
//  Created by Marcelly Luise Souza Godinho on 30/04/17.
//  Copyright © 2017 AIS Tech. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore

class ViewController: UIViewController {
    
    @IBOutlet weak var btnFacebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if FBSDKAccessToken.current() != nil {
            showUserPhoto()
        }
        
        setupFacebookButton()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Facebook Login
    func setupFacebookButton() {
        
        btnFacebookLoginButton.readPermissions = ["public_profile"]
        
        btnFacebookLoginButton.delegate = self
    }
    
    
    // MARK: - Navigation
    func showUserPhoto() {
        performSegue(withIdentifier: "showUserPhoto", sender: self)
    }

}

extension ViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print(result.grantedPermissions)
        
        if FBSDKAccessToken.current().userID != nil {
            showUserPhoto()
        }
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print(#function)
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print(#function)
    }
}
