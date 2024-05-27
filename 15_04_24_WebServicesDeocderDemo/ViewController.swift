//
//  ViewController.swift
//  15_04_24_WebServicesDeocderDemo
//
//  Created by Vishal Jagtap on 27/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var postsRepsonse : [Post] = []
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        registerTableViewWithXIB()
        jsonDecoderForParsingJSON()
    }
    
    func registerTableViewWithXIB(){
        let uiNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        postsTableView.register(uiNib, forCellReuseIdentifier: "PostTableViewCell")
    }
    
    func initViews(){
        postsTableView.delegate = self
        postsTableView.dataSource = self
    }
    
    func jsonDecoderForParsingJSON(){
        url = URL(string: "https://dummyjson.com/posts")
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            let jsonDecoder = JSONDecoder()
            let apiResponseObject = try! jsonDecoder.decode(APIResponse.self, from: data!)
            self.postsRepsonse = apiResponseObject.posts
            for eachPost in self.postsRepsonse{
                print(eachPost.id)
//                print(eachPost.tags)
//                let tagsArray = eachPost.tags
                for eachTag in eachPost.tags{
                    print(eachTag)
                }
                print(eachPost.reactions.likes)
            }
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
        })
        dataTask?.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.postsRepsonse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.postsTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        for eachPostTag in self.postsRepsonse[indexPath.row].tags{
            postTableViewCell.postTagLabel.text = eachPostTag
        }
        
        postTableViewCell.postReactionLikesLabel.text = self.postsRepsonse[indexPath.row].reactions.likes.codingKey.stringValue
        postTableViewCell.postReactionDislikesLabel.text = self.postsRepsonse[indexPath.row].reactions.dislikes.codingKey.stringValue
         
        return postTableViewCell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}
