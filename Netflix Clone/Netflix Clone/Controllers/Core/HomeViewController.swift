//
//  ViewController.swift
//  Netflix Clone
//
//  Created by A on 11/05/2023.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, HomeView {
    
    
    
    @IBOutlet weak var profileButtonPressed: UIBarButtonItem!
    @IBOutlet weak var watchButtonPressed: UIBarButtonItem!
    @IBOutlet weak var homeTableView: UITableView!
    
    var homePresenter : HomeViewPresenter!
    
    let tableIdentifier = "TableViewCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter = HomeViewPresenter(self)

        homeTableView.register(UINib(nibName: tableIdentifier, bundle: nil), forCellReuseIdentifier: tableIdentifier)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        let myheaderView = MyHeaderView(frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeTableView.tableHeaderView = myheaderView
        
        
        //        var netflixLogo = UIImage(named: "netflix-logo")
        //        netflixLogoPressed.setBackgroundImage(netflixLogo?.withRenderingMode(.alwaysOriginal), for: .normal, barMetrics: .default)
        //        netflixLogoPressed.image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "netflix-logo")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homePresenter.sectionTitles.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return homePresenter.sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        header.textLabel?.textColor = .label
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: tableIdentifier) as? TableViewCell  else {return UITableViewCell() }
        
        homePresenter.returnMovieArray(with: cell, at: indexPath)
//        cell.delegate = self
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        230
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func reloadTableView() {
        
    }
    
}

extension HomeViewController: passDataToTitlePreviewVC {
    func setupTitlePreview(title: String, overview: String, webView: String) {
        DispatchQueue.main.async {
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "story") as! TitlePreviewViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            vc.setupTitlePreview(title: title, overview: overview, webView: webView)
            
        }
        
    }
    
}

protocol passDataToTitlePreviewVC: AnyObject {
    func setupTitlePreview(title:String, overview:String, webView:String)
}
