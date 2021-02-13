//
//  MovieDetailsViewController.swift
//  AliFlix
//
//  Created by Ali Ma on 2/12/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        //getting url from API
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl +
                                posterPath)!
        //Now Can give me the url, I'll download it & setup image
        posterView.af_setImage(withURL: posterUrl)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780"
                                + backdropPath)!
        //Now Can give me the url, I'll download it & setup image
        backdropView.af_setImage(withURL: backdropUrl)

        titleLabel.text = movie["title"] as?
            String
        //so then the full description will show:
        titleLabel.sizeToFit()
        
        
        synopsisLabel.text = movie["overview"] as?
            String
        synopsisLabel.sizeToFit()
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
