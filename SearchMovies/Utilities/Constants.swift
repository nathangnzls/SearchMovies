//
//  Constants.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit
typealias resquestCompleted =  (_ message:String, _ data: Any?, _ error: NSError?)-> Void
typealias viewModelCompleted = (_ message: String , _ error : Error?) -> Void
class Constants: NSObject {
    static let BASE_URL =  "http://api.themoviedb.org/"
    static let PATH_MOVIES = "3/search/movie?api_key="
    static let API_KEY = "4b951e36d117bbc88ac54eccece53258"
    static let PATH_IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original"
}
struct alertsMessage{
    static let internetRequired = "An internet connection is required."
}
struct alertsTitle{
    static let internetRequired = "Internet Required"
}
