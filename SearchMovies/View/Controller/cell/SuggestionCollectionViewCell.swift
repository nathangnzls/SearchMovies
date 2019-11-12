//
//  SuggestionCellCollectionViewCell.swift
//  SearchMovies
//
//  Created by Nathan on 12/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var suggestionBtn: UIButton!
    var searchMovies : String? {
        didSet{
            self.suggestionBtn.setTitle(searchMovies ?? "", for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
