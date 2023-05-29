//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by A on 22/05/2023.
//

import UIKit
import SDWebImage

class TitleTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "TitleTableViewCell"
    
    @IBOutlet weak var playButtonPressed: UIButton!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var titleImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(poster:String, title:String) {
        titleLabel.text = title
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else {return}
        titleImageView.sd_setImage(with: url, completed: nil)
    }

    
    
}
