//
//  SuperHeroDetailViewController.swift
//  Flix
//
//  Created by zhong zheng on 1/31/21.
//  Copyright © 2021 ZHONG ZHENG. All rights reserved.
//

import UIKit
import AlamofireImage
class SuperHeroDetailViewController: UIViewController {
    
    var movie: [String:Any]!
    var videoURL: String!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl+posterPath)
        posterView.af_setImage(withURL: posterUrl!)
        
        guard let backdropPath = movie["backdrop_path"] as? String else { return  }
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780"+backdropPath)
        backdropView.af_setImage(withURL: backdropUrl!)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        posterView.addGestureRecognizer(tapGR)
        posterView.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(sender:UITapGestureRecognizer) {
        if sender.state == .ended {
            let id = movie["id"] as! Int
             let url = URL(string: "https://api.themoviedb.org/3/movie/"+String(id)+"/videos?api_key=4651f265631cee5aebea8a3674f3b0c7&language=en-US")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
               // This will run when the network request returns
               if let error = error {
                  print(error.localizedDescription)
               } else if let data = data {
                  let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = dataDictionary["results"] as! [[String:Any]]
                let key = results[0]["key"]!
                self.videoURL = "https://www.youtube.com/watch?v=\(key)"
                self.performSegue(withIdentifier: "watchVideo", sender: nil)
               }
            }
            task.resume()
                        
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let videoViewController = segue.destination as! tailerViewController
        videoViewController.videoURL = URL(string:videoURL)
    }
    

}
