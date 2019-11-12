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
//sample data
/*
 {popularity: 13.068,
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
                    12],
        backdrop_path: "/k88XKMUDhOM0df0uEJrjYgDBR7r.jpg",
        adult: false,
        overview: "The standalone film with The Flash set in the DC Extended Universe.",
        poster_path: "/kmnAoGuTKMHYHKAs4A9okSXxgBm.jpg"
 },
 */
