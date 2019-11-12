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
/*
 page: 1,
 total_results: 166,
 total_pages: 9,
 results: [{popularity: 13.068,
            id: 298618,
            video: false,
            vote_count: 0,
            vote_average: 0,
            title: "The Flash",
            release_date: "2021-06-18",
            original_language: "en",
            original_title: "The Flash",
            genre_ids: [28,
                        878,
                        14,
                        12],....
 */
