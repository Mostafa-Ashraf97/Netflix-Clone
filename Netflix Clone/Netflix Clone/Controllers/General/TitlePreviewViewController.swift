//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by A on 31/05/2023.
//

import UIKit
import WebKit



class TitlePreviewViewController: UIViewController {

    var labelText: String?
    var overviewText: String?
//    var trailerWebview: WKWebView?
    var trailerUrl: String?
    
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var myOverviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTitleLabel.text = labelText
        myOverviewLabel.text = overviewText
        
        guard let trailerUrl = trailerUrl else {return}
        guard let url = URL(string: trailerUrl) else {return}
        
        myWebView?.load(URLRequest(url: url))
//        myWebView = trailerWebview

    }
    func setupTitlePreview(title:String, overview:String, webView:String) {
        labelText = title
      overviewText = overview
        
        let myUrl = "https://www.youtube.com/embed/\(webView)"
        trailerUrl = myUrl
        
    }
    
}
    




struct model {
    var title:String
    var overview:String
    var webView:WKWebView
}
