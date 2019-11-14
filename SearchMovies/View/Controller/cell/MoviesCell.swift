//
//  MoviesCell.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit
import Nuke
protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}
class MoviesCell: UITableViewCell {
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var blurredImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDateAndRatings: UILabel!
    @IBOutlet weak var overview: UILabel!
    var results : Results? {
        didSet{
            guard let url = URL(string: Constants.PATH_IMAGE_BASE_URL+(results?.poster_path ?? "")) else {return}
            Nuke.loadImage(with: url, into: self.posterImg)
            Nuke.loadImage(with: url, into: self.blurredImage)
            self.title.text = results?.title
            self.releaseDateAndRatings.text = "\(Constants.releaseDateAndRatings)\(results?.release_date ?? "") - \(results?.vote_average ?? 0.0)"
            self.overview.text = results?.overview
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
