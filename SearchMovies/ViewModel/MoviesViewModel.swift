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
                        self?.tempModel = movies.results
//                        for i in 0..<movies.results.count{
//                            self?.tempModel?.append(movies.results[i])
//                            print("arr count \(self?.tempModel?.count)")
//                        }
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
