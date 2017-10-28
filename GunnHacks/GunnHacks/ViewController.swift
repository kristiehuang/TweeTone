//
//  ViewController.swift
//  GunnHacks
//
//  Created by Jacob Kim on 10/27/17.
//  Copyright © 2017 Jacob Kim. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("wwww")
        
        motionManager.gyroUpdateInterval = 0.2
        
        let dispatchQueue = DispatchGroup()
        dispatchQueue.enter()
        
        dispatchQueue.notify(queue: .main, execute: {
            print("hello pls work")
        })
        
        
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in

            print("asdfjskaf")

            if let myData = data {
                print (myData.rotationRate)
                
                if myData.rotationRate.x > 3 {
                    print("X direction turned")
                }
                
                if myData.rotationRate.y > 3 {
                    print("Y direction turned")
                }
                
                if myData.rotationRate.z > 3 {
                    print("Z direction turned")
                }
            }
            
            dispatchQueue.leave()
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

