//
//  MovieGridViewController.swift
//  Flix
//
//  Created by zhong zheng on 1/31/21.
//  Copyright © 2021 ZHONG ZHENG. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var movies = [[String:Any]]()
    
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - 2*layout.minimumInteritemSpacing) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=4651f265631cee5aebea8a3674f3b0c7&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.collectionView.reloadData()
           }
        }
        task.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl+posterPath)
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let itemPath = collectionView.indexPath(for: cell)!
        let movie = movies[itemPath.item]
        let detailsVC = segue.destination as! SuperHeroDetailViewController
        detailsVC.movie = movie
        collectionView.deselectItem(at: itemPath, animated: true)
        
    }
    

}
