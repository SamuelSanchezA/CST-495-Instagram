//
//  ViewController.swift
//  instagram-assignment
//
//  Created by Samuel on 2/10/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginClick(_ sender: Any) {
        print("Login clicked")
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user, error) in
            if user != nil{
                print("You're logged in")
            }
            else{
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    @IBAction func onSignUpClick(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success, error) in
            if success{
                print("Signup good!")
            }
            else{
                print(error?.localizedDescription ?? "")
            }
        }
    }
}

