//
//  UserPhotoViewController.swift
//  FacebookLogin
//
//  Created by Marcelly Luise Souza Godinho on 30/04/17.
//  Copyright © 2017 AIS Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore


class UserPhotoViewController: UIViewController {

    @IBOutlet weak var imgUserPhoto: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFacebookId: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnLogout: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        struct MyProfileRequest: GraphRequestProtocol {
            
            struct Response: GraphResponseProtocol {
                
                var email: String?
                var facebookId: String?
                var name: String?
                var gender: String?
                var pictureUrl: String?
                
                init(rawResponse: Any?) {
                    
                    
                    if let data = rawResponse as? NSDictionary {
                        if let facebookId = data["id"] as? String {
                            print("Id da criatura: \(facebookId)")
                            self.facebookId = facebookId
                        }
                        
                        if let email = data["email"] as? String {
                            print(email)
                            self.email = email
                        }
                        
                        if let name = data["name"] as? String {
                            print(name)
                            self.name = name
                        }
                        
                        if let gender = data["gender"] as? String {
                            print(gender)
                            self.gender = gender
                        }
                        
                        if let pictureDic = data["picture"] as? NSDictionary {
                            print(pictureDic)
                            
                            if let picData = pictureDic["data"] as? NSDictionary {
                                print(picData)
                                
                                if let pictureUrl = picData["url"] as? String {
                                    print(pictureUrl)
                                    
                                    self.pictureUrl = pictureUrl
                                }
                            }
                        }
                    }
                    
                }
            }
            
            var graphPath = "/me"
            var parameters: [String : Any]? = ["fields": "id, name, email, gender, picture"]
            var accessToken: AccessToken? = AccessToken.current
            var httpMethod: GraphRequestHTTPMethod = .GET
            var apiVersion: GraphAPIVersion = .defaultVersion
            
        }
        
        let connection = GraphRequestConnection()
        
        connection.add(MyProfileRequest()) { response, result in
        
            switch result {
            case .success(let graphResponse):
                print("Graph success: \(graphResponse)")
                
                DispatchQueue.main.async {
                    
                    if let name = graphResponse.name {
                        self.lblName.text = name
                    }
                    
                    if let facebookId = graphResponse.facebookId {
                        self.lblFacebookId.text = facebookId
                    }
                    
                    if let gender = graphResponse.gender {
                        self.lblGender.text = gender
                    }
                    
                    if let email = graphResponse.email {
                        self.lblEmail.text = email
                    } else {
                        self.lblEmail.text = "User denied email info"
                    }
                    
                    if let pictureUrl = graphResponse.pictureUrl {
                        
                        let data = try? Data(contentsOf: URL(string: pictureUrl)!)
                        
                        
                        DispatchQueue.global().async {
                            DispatchQueue.main.async {
                                
                                self.imgUserPhoto.image = UIImage(data: data!)
                            }
                        }
                        
                    }
                    
                    
                    
                }
                
                
                
            case .failed(let error):
                print("error: \(error)")
            }
        }
        
        connection.start()
        
    }


}
