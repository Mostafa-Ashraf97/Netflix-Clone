//
//  MyHeaderView.swift
//  Netflix Clone
//
//  Created by A on 16/05/2023.
//

import UIKit

class MyHeaderView: UIView {

    
    @IBOutlet weak var headerImageView : UIImageView!

    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
   
    @IBOutlet weak var myView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
//        headerImageView.image = UIImage(named: "wick")
//        addGradient()
        setupButtons()
        randomPoster()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func loadNib() {
        Bundle.main.loadNibNamed("MyHeaderView", owner: self)
        addSubview(myView)
        myView.frame = self.bounds
        myView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    
    }
//    func addGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor.clear.cgColor,
//            UIColor.systemBackground.cgColor
//        ]
//        layer.addSublayer(gradientLayer)
//        gradientLayer.frame = bounds
//    }
    func setupButtons() {
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = 2
        playButton.layer.cornerRadius = 6
        downloadButton.layer.borderColor = UIColor.white.cgColor
        downloadButton.layer.borderWidth = 2
        downloadButton.layer.cornerRadius = 6
    }
    
    func randomPoster() {
        Networking.shared.fetchData(with: #"trending/movie/day"#) { results in
            switch results {
            case .success(let movie):
                let randomMovie = movie.randomElement()
                let randomPoster = randomMovie?.posterPath
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(randomPoster ?? "")") else { return }
//                DispatchQueue.main.async {
                self.headerImageView.sd_setImage(with: url)
//                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
