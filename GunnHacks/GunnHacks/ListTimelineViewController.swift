//
//  ViewController.swift
//  GunnHacks
//
//  Created by Jacob Kim on 10/27/17.
//  Copyright © 2017 Jacob Kim. All rights reserved.
//

import UIKit
import TwitterKit

class ListTimelineViewController: TWTRTimelineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        let dataSource = TWTRSearchTimelineDataSource(searchQuery: "trending", apiClient: client)
        dataSource.resultType = "popular"
    }
}
