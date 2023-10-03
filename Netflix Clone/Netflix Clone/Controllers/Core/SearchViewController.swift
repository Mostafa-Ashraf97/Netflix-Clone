//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by A on 12/05/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    var titles = [Title]()
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        setupTableView()
        fetchData()
        navigatingToSearchResultVC()
    }
    
    func fetchData() {
        Networking.shared.getDiscoverdMovies(with: "") { results in
            switch results {
            case .success(let title) :
                self.titles = title
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    func navigatingToSearchResultVC(){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let searchResultViewController =  story.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        let mySearchController = UISearchController(searchResultsController: searchResultViewController)
        navigationItem.searchController = mySearchController
        mySearchController.searchBar.placeholder = "Search for a Movie or a TV Show"
        mySearchController.searchResultsUpdater = self
    }
    
    func setupTableView(){
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: TitleTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TitleTableViewCell.cellIdentifier)
    }
}

extension SearchViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.cellIdentifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        let myTitle = titles[indexPath.row]
        cell.configure(poster: myTitle.posterPath ?? "", title: myTitle.title ?? "Unknown")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty,
              text.trimmingCharacters(in: .whitespaces).count > 2 ,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {return}
        Networking.shared.search(with: text) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    resultController.searchedArray = title
                    resultController.searchCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
