//
//  HomeFeedViewController.swift
//  instagram-assignment
//
//  Created by Samuel on 2/11/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var postTableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "Home Feed"
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        fetchPosts()
        // Do any additional setup after loading the view.
    }
    
    func fetchPosts(){
        let query = Post.query()
        query?.findObjectsInBackground(block: { (posts, error) in
            if(posts != nil){
                self.posts = posts as! [Post]
                print(self.posts)
                self.postTableView.reloadData()
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
    
    @IBAction func logout(_ sender: Any) {
        // Make sure user is signed out and modal segue back to login view
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.postCaptionLabel.text = post.caption
        
        if let extractedImage = post.media as! PFFile?{
            extractedImage.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                let image = UIImage(data: imageData!)
                if image != nil {
                    cell.postImageView.image = image
                }
            })
        }
        
        return cell
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
