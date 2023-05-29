//
//  CollectionViewCell.swift
//  Netflix Clone
//
//  Created by A on 13/05/2023.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
static let cellIdentifier = "CollectionViewCell"
    @IBOutlet weak var myImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMyPosterImage(with model:String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
        myImageView.sd_setImage(with: url)
    }
}
