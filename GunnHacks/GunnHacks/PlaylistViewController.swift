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
    
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var playlistButton: UIButton!
    
    var mood = ""
    var playlistURL = ""
    
    //sample small list of keywords
    let happWords = [":)", ";)", "happy", "good", "yay", "better", "fun", "twttr", "great", "amazing"]
    let sadWords = [":(", "sad", "cry", "worst", "death", "unfortunately", "darn", "oh"]
    let angryWords = ["mad", "angry", "furious", "nerve"]
    let fearWords = ["scary", "scared", "terrifying"]
    
    var playlists : [String: String] = ["happy":"https://open.spotify.com/user/spotify/playlist/37i9dQZF1DWYBO1MoTDhZI",
                                        "sad":"https://open.spotify.com/user/spotify/playlist/37i9dQZF1DXbvABJXBIyiY",
                                        "angry":"https://open.spotify.com/user/spotify/playlist/37i9dQZF1DX8gLrc0tlHvS",
                                        "fear":"https://open.spotify.com/user/spotify/playlist/37i9dQZF1DXa2PsvJSPnPf",
                                        "neutral":"https://open.spotify.com/user/spotify/playlist/37i9dQZF1DX0jgyAiPl8Af"]

    func assessEmotion(tweet: String) -> String {
        var emotionFreqs = [String: Int]()
        emotionFreqs["happy"] = 0
        emotionFreqs["sad"] = 0
        emotionFreqs["angry"] = 0
        emotionFreqs["fear"] = 0
        emotionFreqs["neutral"] = 0
        
        
        for t in TimelineTableViewController.tweets {
            print(t)
            if (t != "") {
            let tweetSplit = t.components(separatedBy: " ")
            var emotionPercentages = [String: Double]()
            emotionPercentages["happy"] = happyPercent(tweetSplit : tweetSplit);
            emotionPercentages["sad"] = sadPercent(tweetSplit : tweetSplit);
            emotionPercentages["angry"] = angryPercent(tweetSplit : tweetSplit);
            emotionPercentages["fear"] = fearPercent(tweetSplit : tweetSplit);
            emotionPercentages["neutral"] = 0.0;
            
            let thisemotion = maxPercentKey(epercents: emotionPercentages)
            print(thisemotion)
            emotionFreqs[thisemotion]! += 1
            }
            else{
                print("tweet was null")
            }
            
            print("happy: \(emotionFreqs["happy"])")
            print("sad: \(emotionFreqs["sad"])")
            print("angry: \(emotionFreqs["angry"])")
            print("fear: \(emotionFreqs["fear"])")
            print("neutral: \(emotionFreqs["neutral"])")
        }
        
        let worldmood = maxFreqKey(emotionFreqs : emotionFreqs)
        return worldmood
    }
    
    
    func happyPercent(tweetSplit : [String]) -> Double {
        var hc = 0.0
        var c = 0.0
        for t in tweetSplit {
            c += 1
            if (happWords.contains(t)) {
                hc += 1
            }
        }
        print("happy percent:")
        print(hc/c)
        return hc / c
    }
    
    func sadPercent(tweetSplit : [String]) -> Double {
        var sc = 0.0
        var c = 0.0
        for t in tweetSplit {
            c += 1
            if (sadWords.contains(t)) {
                sc += 1
            }
        }
        print("sad percent:")
        print(sc/c)
        return sc / c
    }
    
    func angryPercent(tweetSplit : [String]) -> Double {
        var ac = 0.0
        var c = 0.0
        for t in tweetSplit {
            c += 1
            if (angryWords.contains(t)) {
                ac += 1
            }
        }
        print("angry percent:")
        print(ac/c)
        return ac / c
    }
    
    func fearPercent(tweetSplit : [String]) -> Double {
        var fc = 0.0
        var c = 0.0
        for t in tweetSplit {
            c += 1
            if (fearWords.contains(t)) {
                fc += 1
            }
        }
        print("fear percent:")
        print(fc/c)
        return fc / c
    }
    
    
    func maxPercentKey(epercents : [String: Double]) -> String {
        var max = 0.0
        var maxKey = "neutral"
        for key in epercents.keys {
            if (epercents[key] != 0.0) {
                print("key: " + key)
                print("epercents[key]: ")
                print(epercents[key])
            }
            if (epercents[key]! > max) {
                max = epercents[key]!
                maxKey = key
            }
        }
        print(maxKey)
        return maxKey
    }
    
    func maxFreqKey(emotionFreqs : [String: Int]) -> String {
        var max = 0
        var maxKey = ""
        
        //if all other emotions frequencies are zero, emotion is set to neutral
        var allZero = true
        for index in 0...(emotionFreqs.count-2) {
            let key = [String](emotionFreqs.keys)[index]
            if (emotionFreqs[key] != 0) {
                allZero = false
            }
        }
        if (allZero) {
            maxKey = "neutral"
            print(maxKey)
            return maxKey
        }
        
        //otherwise ignores neutral altogether and looks at other emotions
        //@precondition: neutral must be the last emotion in emotionFreqs
        for index in 0...(emotionFreqs.count-2) {
            let key = [String](emotionFreqs.keys)[index]
            if (emotionFreqs[key]! > max) {
                max = emotionFreqs[key]!
                maxKey = key
            }
        }
        print(maxKey)
        return maxKey
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM dd, YYYY"
        let result = formatter.string(from: date)

        dateLabel.text = "Today, \(result),"
        
        var emotion = assessEmotion(tweet: TimelineTableViewController.tweetString)
        print(emotion)
        playlistURL = playlists[emotion]!
        moodLabel.text = emotion

        
        
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
    @IBAction func showTweetsTapped(_ sender: Any) {
        
    }
    
    @IBAction func playlistButtonTapped(_ sender: Any) {
        
        UIApplication.shared.openURL(URL(string: playlistURL)!)

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
