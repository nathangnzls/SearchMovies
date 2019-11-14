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
    static let BASE_URL = Environment.baseURL
    static let PATH_MOVIES = "3/search/movie?api_key="
    static let API_KEY = "4b951e36d117bbc88ac54eccece53258"
    static let PATH_IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original"
    
    static let releaseDateAndRatings = "Release date and rating: "
}
struct alertsMessage{
    static let internetRequired = "An internet connection is required."
    static let noInternetConecction = "Please Check your Internet Connection and try again"
}
struct alertsTitle{
    static let internetRequired = "Internet Required"
}
struct nibNames{
    static let movieCell = "MovieCell"
    static let suggestionCell = "SuggestionCell"
}
struct nibIds{
    static let movieCellID = "MoviesCell"
    static let suggestionID = "SuggestionCollectionViewCell"
}
struct placeHolder{
    static let searchView = "Search movie names here"
}
struct loaderTitle{
    static let loading = "Loading contents..."
}
