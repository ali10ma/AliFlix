//
//  MovieGridViewController.swift
//  AliFlix
//
//  Created by Ali Ma on 2/12/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        //Create some spaces between images in Grid
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //Space b/w top and bottom Image
        layout.minimumLineSpacing = 0
        
        //Spacing between items LHS & RHS
        layout.minimumInteritemSpacing = 0
        
        //Affects #Image per row
        let width = (view.frame.size.width) / 3
        layout.itemSize = CGSize(width: width, height: width*3/2)
        
        
        // Do any additional setup after loading the view.
        //Replace url for superhero related movies
        // let url = URL(string: //"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let url = URL(string: "https://api.themoviedb.org/3/movie/464052/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error)
            in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try!
                JSONSerialization.jsonObject(with: data, options: [])as! [String: Any]
            
            //Download the above list of movies
            //Store it to below line
            //Casting as an array of dictionary, start from as![[]]
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.collectionView.reloadData()
            
          //  self.tableView.reloadData()//its gonna call the function/data again!!
            
            print(dataDictionary)

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

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
        
        //getting url from API
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl +
                                posterPath)!
        //Now Can give me the url, I'll download it & setup image
        cell.posterView.af_setImage(withURL: posterUrl)
        
        
        
        return cell
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
