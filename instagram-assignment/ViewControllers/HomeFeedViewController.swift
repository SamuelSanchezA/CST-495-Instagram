//
//  HomeFeedViewController.swift
//  instagram-assignment
//
//  Created by Samuel on 2/11/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit

class HomeFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "Home Feed"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        // Make sure user is signed out and modal segue back to login view
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
