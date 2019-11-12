//
//  ResultsModel.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit

class ResultsModel: NSObject {
    var results = [Results]()
    init(json: [String:Any]){
        let arr = json["results"] as? [AnyObject]
        for item in arr ?? []{
            self.results.append(Results.init(json: item as! [String : Any]))
        }
    }

}
