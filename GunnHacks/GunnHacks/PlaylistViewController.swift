//
//  PlaylistViewController.swift
//  GunnHacks
//
//  Created by Jacob Kim on 10/27/17.
//  Copyright © 2017 Jacob Kim. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import AlamofireSwiftyJSON
import Alamofire

typealias ServiceResponse = (JSONSerialization, NSError?) -> Void


class PlaylistViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodImage: UIImageView!
    
    @IBOutlet weak var playlistButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        
        guard let jsonURL = Bundle.main.url(forResource: "iTunes-Movies", withExtension: "json") else {
            print("Could not find iTunes-Movies.json!")
            return
        }
        
        let jsonData = try! Data(contentsOf: jsonURL)
        
        let moviesData = JSON(data: jsonData)
        
        let allMoviesData = moviesData["feed"]["entry"].arrayValue
        
        let randomMovieIndex: Int = Int(arc4random_uniform(24))
        
        let randomMovieData = allMoviesData[randomMovieIndex]
        let randomMovie = Movie(json: randomMovieData)
        self.mov = randomMovie
        */
        
        
        let apiToContact = "https://gateway.watsonplatform.net/tone-analyzer/api/v3/tone?version=2017-09-21&text=Team hi there this is good I hate pie this is horrible bad and terrible! I love school and think it is great! Unfortunately, it is raining tonight so the game will have to be cancelled. I am sorry. I am also only testing this so this is nonsense but that is okay."
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let _ = JSON(value)
                    
                    print(value)
                   /* self.movieTitleLabel.text = randomMovie.name
                    self.rightsOwnerLabel.text = randomMovie.rightsOwner
                    self.releaseDateLabel.text = randomMovie.releaseDate
                    self.priceLabel.text = String("$\(randomMovie.price)")
                    self.loadPoster(urlString: randomMovie.posterURL)
                    */
                    
                }
            case .failure(let error):
                print(error)
            }
        }

        
        
    }
    
    
    @IBAction func playlistButtonTapped(_ sender: Any) {
        
        UIApplication.shared.openURL(URL(string: "https://open.spotify.com/user/spotify/playlist/37i9dQZF1DXbvABJXBIyiY")!)

    }
    
    /*
    
    func getTone(onCompletion: @escaping (JSONSerialization) -> Void) {
        let baseURL = "https://gateway.watsonplatform.net/tone-analyzer/api/v3/tone?version=2017-09-21&text=This is bad and I am testing out horrible bad angry"
        let route = baseURL
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSONSerialization)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            let json = JSON(data: data)
            onCompletion(json, error as! NSError)
        })
        task.resume()
    }
 */
    
    
    
}
