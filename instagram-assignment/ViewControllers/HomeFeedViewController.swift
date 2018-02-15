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
    var refreshControl : UIRefreshControl!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "Home Feed"
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        postTableView.insertSubview(refreshControl, at: 0)
        fetchPosts()
        // Do any additional setup after loading the view.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchPosts()
    }
    
    func fetchPosts(){
        let query = Post.query()
        query?.limit = 20
        query?.order(byDescending: "_created_at")
        query?.findObjectsInBackground(block: { (posts, error) in
            if(posts != nil){
                self.posts = posts as! [Post]
                self.postTableView.reloadData()
                self.refreshControl.endRefreshing()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.section]
        cell.postCaptionLabel.text = post.caption
        cell.postImageView.file = post.media
        cell.postImageView.loadInBackground()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // Set the avatar
        profileView.image = #imageLiteral(resourceName: "profile_tab")
        headerView.addSubview(profileView)
        
        // Add a UILabel for the date here
        // Use the section number to get the right URL
        // let label = ...
        
        let label: UILabel = UILabel(frame: CGRect(x: 60, y: 10, width: 320, height: 30))
        
        let query = PFUser.query()
        query?.getObjectInBackground(withId: posts[section].author.objectId!, block: { (user, error) in
            if(user != nil){
                label.text = (user as! PFUser).username ?? "Unknown"
            }
            else{
                print(error?.localizedDescription)
            }
        })
        
        headerView.addSubview(label)
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
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
