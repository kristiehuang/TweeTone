//
//  PlaylistViewController.swift
//  GunnHacks
//
//  Created by Jacob Kim on 10/27/17.
//  Copyright © 2017 Jacob Kim. All rights reserved.
//

import Foundation
import UIKit

typealias ServiceResponse = (JSONSerialization, NSError?) -> Void


class PlaylistViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodImage: UIImageView!
    
    @IBOutlet weak var playlistButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
