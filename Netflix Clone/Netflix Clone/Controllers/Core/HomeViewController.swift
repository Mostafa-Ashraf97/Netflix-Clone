//
//  ViewController.swift
//  Netflix Clone
//
//  Created by A on 11/05/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var profileButtonPressed: UIBarButtonItem!
    @IBOutlet weak var watchButtonPressed: UIBarButtonItem!
    
    @IBOutlet weak var homeTableView: UITableView!
    
    let tableIdentifier = "TableViewCell"
    let sectionTitles : [String] = ["Trending Movies","Popular","Trending TV","Upcoming Movies","Top Rated"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
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
    switch indexPath.section {
    case sections.TrendingMovies.rawValue:
        Networking.shared.fetchData(with: #"trending/movie/day"#) { results in
            switch results {
            case .success(let movie):
                cell.passTitleArray(title: movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
    case sections.Popular.rawValue:
        Networking.shared.fetchData(with: #"movie/popular"#) { results in
            switch results {
            case .success(let movie):
                cell.passTitleArray(title: movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    case sections.TrendingTV.rawValue:
        Networking.shared.fetchData(with: #"trending/tv/day"#) { results in
            switch results {
            case .success(let TV):
                cell.passTitleArray(title: TV)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    case sections.UpComingMovies.rawValue:
        Networking.shared.fetchData(with: #"movie/upcoming"#) { results in
            switch results {
            case .success(let movie):
                cell.passTitleArray(title: movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    case sections.TopRated.rawValue:
        Networking.shared.fetchData(with: #"movie/top_rated"#) { results in
            switch results {
            case .success(let movie):
                cell.passTitleArray(title: movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    default:
        return UITableViewCell()
    }
    return cell
}
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        230
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        80
    }
}


enum sections: Int {
    case TrendingMovies = 0
    case Popular = 1
    case TrendingTV = 2
    case UpComingMovies = 3
    case TopRated = 4
}
