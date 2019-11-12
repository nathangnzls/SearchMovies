//
//  GenericModel.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit

class GenericModel: NSObject {
    var resultsModel: ResultsModel?
    init(json: [String:Any]){
        self.resultsModel = ResultsModel.init(json: json)
    }
}
