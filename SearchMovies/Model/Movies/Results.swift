//
//  Results.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit

class Results: NSObject {
    var poster_path: String?
    var title: String?
    var release_date: String?
    var vote_average: Double?
    var overview: String?
    init(json: [String:Any]){
        self.poster_path = json["poster_path"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.release_date = json["release_date"] as? String ?? ""
        self.vote_average = json["vote_average"] as? Double ?? 0.0
        self.overview = json["overview"] as? String ?? ""
    }
}
