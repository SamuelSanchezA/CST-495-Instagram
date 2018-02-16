//
//  DetailPostViewController.swift
//  instagram-assignment
//
//  Created by Samuel on 2/14/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import ParseUI

class DetailPostViewController: UIViewController {

   
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postAuthorLabel: UILabel!
    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var postImageView: PFImageView!
    
    var imageFile: PFFile!
    var authorName: String!
    var postDate: String!
    var profileImage: PFFile!
    var postCaption: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.file = imageFile
        postImageView.loadInBackground()
        postAuthorLabel.text = authorName
        postCaptionLabel.text = postCaption
        postDateLabel.text = postDate
        profileImageView.image = #imageLiteral(resourceName: "profile_tab")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
