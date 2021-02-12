//
//  MoviesViewController.swift
//  AliFlix
// Purpose of this swift file: Download the list of movies & store it; 
//
//  Created by Ali Ma on 2/11/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    

    @IBOutlet weak var tableView: UITableView!
    
    
    //Property variable called movies, an array of dictionary[[Key: Value]]; () for creation
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Will Show& Print row:# for each row
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Do any additional setup after loading the view.
        print("Hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try!
                JSONSerialization.jsonObject(with: data, options: [])
                as! [String: Any]
            
            //Download the above list of movies
            //Store it to below line
            //Casting as an array of dictionary, start from as![[]]
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.tableView.reloadData()//its gonna call the function/data again!!
            
            print(dataDictionary)

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count   //was: means make 50 rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as!
            MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        
        cell.titleLabel!.text = title//"row: \(indexPath.row)" //means indexPath. row is change this row 50 times,
        cell.synopsisLabel.text = synopsis
        
        //configure itself
        // the ? is for...
        
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
