//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by A on 12/05/2023.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    var titleArray:[Title] = []
    weak var delegate: passDataToTitlePreviewVC?
    
    @IBOutlet weak var upcomingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coming Soon"
        setupTableView()
        fetchData()
    }
    
    func setupTableView(){
        upcomingTableView.dataSource = self
        upcomingTableView.delegate = self
        upcomingTableView.register(UINib(nibName: TitleTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TitleTableViewCell.cellIdentifier)
    }
    
    func fetchData() {
        Networking.shared.fetchData(with: #"movie/upcoming"#) { results in
            switch results {
            case .success(let movie):
                self.titleArray = movie
                DispatchQueue.main.async {
                    self.upcomingTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = upcomingTableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.cellIdentifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        let titlePoster = titleArray[indexPath.row].posterPath
        let titleText = titleArray[indexPath.row]
        cell.configure(poster: titlePoster ?? "", title: titleText.title ?? "Unknown" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = titleArray[indexPath.item]
        let titleName = model.originalTitle ?? model.name ?? model.originalName ?? model.title ?? ""
        let titleSearch = titleName + " Trailer"
        DispatchQueue.main.async {
          guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "story") as? TitlePreviewViewController
          else { return }
          vc.titleName = titleName
          vc.model = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
