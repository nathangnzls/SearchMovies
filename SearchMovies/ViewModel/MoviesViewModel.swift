//
//  MoviesViewModel.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit

class MoviesViewModel: NSObject {
    var resultsModel: ResultsModel?
    var tempModel: [Results]?
    var tempData : [Results]? = []
    var searchedMovie = [String]()
    func fetchMovies(movieName: String, pageNum: Int,_ completed: @escaping viewModelCompleted){
        APIHandler.shared.get(request: .fetchMovies, movieName: movieName, pageNum: pageNum ,parameters: [:]) {[weak self] (message, object, error) in
                   if error != nil{
                       completed(message, error)
                   }else{
                    guard let generic = object as? GenericModel else{
                               return completed("An error occured. \(message) Please try again" , nil)
                    }
                    guard let movies =  generic.resultsModel else{
                               return completed("An error occured. Please try again" , nil)
                    }
                    if movies.results.count == 0{
                         return completed("No results found" , nil)
                    }else{
                        if(!(self?.searchedMovie.contains(movieName) ?? false)){
                            if(self?.searchedMovie.count ?? 1 <= 9){
                                self?.searchedMovie.append(movieName)
                            }else{
                                self?.searchedMovie.removeFirst()
                                self?.searchedMovie.append(movieName)
                            }
                        }
                        self?.tempModel = movies.results
                        self?.tempData! += self?.tempModel ?? []
                        self?.resultsModel = movies
                        
                        return completed(message, nil)
                    }
                   }
               }
    }
    func moviesCount() -> Int{
        self.tempModel?.count ?? 0
    }
}
