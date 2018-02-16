//
//  ProfileViewController.swift
//  instagram-assignment
//
//  Created by Samuel on 2/12/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userPostsCollectionView: UICollectionView!
    
    var userPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        userPostsCollectionView.dataSource = self
        userPostsCollectionView.delegate = self
        let layout = userPostsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine : CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = userPostsCollectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width)
        fetchUserPosts()
    }

    func fetchUserPosts(){
        PFUser.getCurrentUserInBackground().continueOnSuccessWith { (user) -> Any? in
            self.usernameLabel.text = user.result?.username
        }
        let query = Post.query()
        query?.whereKey("author", equalTo: PFUser.current())
        query?.order(byDescending: "_created_at")
        query?.findObjectsInBackground(block: { (posts, error) in
            if(posts != nil){
                self.userPosts = posts as! [Post]
                self.userPostsCollectionView.reloadData()
                //self.refreshControl.endRefreshing()
            }
            else{
                print(error?.localizedDescription)
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let imageFile = userPosts[indexPath.row].media
        
        cell.photoImageView.file = imageFile
        cell.photoImageView.loadInBackground()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailPostViewController
        
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
