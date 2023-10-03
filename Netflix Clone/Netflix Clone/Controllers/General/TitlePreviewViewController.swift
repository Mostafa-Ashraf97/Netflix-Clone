//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by A on 31/05/2023.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    var titleName: String?
    var model: Title?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var myOverviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrievePreviewData()
    }
    
    private func setupUI(with movie: VideoElement) {
        guard
            let model = self.model,
            let title = self.titleName,
            let movieID = movie.id?.videoId
        else { return }
        myTitleLabel.text = title
        myOverviewLabel.text = model.overview
        let myUrl = "https://www.youtube.com/embed/\(movieID)"
        guard let url = URL(string: myUrl) else {return}
        myWebView?.load(URLRequest(url: url))
    }
    
    private func retrievePreviewData() {
        let titleSearch = "\(titleName ?? "") Trailer"
        activityIndicator.startAnimating()
        Networking.shared.getTitlePreview(with: titleSearch) { result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidesWhenStopped = true
                    self.setupUI(with: movie)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct model {
    var title:String
    var overview:String
    var webView:WKWebView
}
