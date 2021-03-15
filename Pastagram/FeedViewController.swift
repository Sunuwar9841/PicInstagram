//
//  FeedViewController.swift
//  Pastagram
//
//  Created by alisha.sunuwar on 3/13/21.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    //variales
        var posts = [PFObject]()
        var refreshControl : UIRefreshControl!
        var numberOfPosts : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
               
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
        self.loadPosts()
    }
    
    
    //load post from the server
       @objc func loadPosts(){
           numberOfPosts = 5;
           let query = PFQuery(className: "Posts")
           query.includeKey("author")
           query.limit = numberOfPosts
           query.order(byDescending: "createdAt")
           
           query.findObjectsInBackground { (posts, error) in
               if posts != nil{
                   self.posts = posts!
                   self.tableView.reloadData()
                   self.tableView.refreshControl?.endRefreshing()
               }else{
                   print("error fetching data : \(error!.localizedDescription)")
               }
           }
       }
    
    
    func loadMorePosts(){
          let query = PFQuery(className: "Posts")
          query.includeKey("author")
          numberOfPosts += 2
          query.limit = numberOfPosts
          query.order(byDescending: "createdAt")

          query.findObjectsInBackground { (posts, error) in
              if posts != nil{
                  self.posts = posts!
                  self.tableView.reloadData()
                  self.tableView.refreshControl?.endRefreshing()
              }else{
                  print("error fetching data : \(error!.localizedDescription)")
              }
          }
      }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
                
        let user = post["author"] as? PFUser
        let captions = post["caption"] as? String
                
        cell.captionLabel.text = captions
        cell.nameLable.text = user?.username
                
        //image
        let imageFile = post["image"] as! PFFileObject
        let imageUrl = imageFile.url!
        let url = URL(string: imageUrl)!
                
        cell.myImage.af.setImage(withURL: url)
                
        return cell
    }
    
    //for loading post when scrolled
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row + 1 == posts.count{
                loadMorePosts()
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
