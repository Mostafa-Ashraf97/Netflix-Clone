//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by A on 24/05/2023.
//

import UIKit

class SearchResultViewController: UIViewController {
    var searchedArray:[Title] = []
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        searchCollectionView.register(
            UINib(
                nibName: CollectionViewCell.cellIdentifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CollectionViewCell.cellIdentifier
        )
    }
}

extension SearchResultViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellIdentifier, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        let title = searchedArray[indexPath.item]
        cell.setMyPosterImage(with: title.posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 160, height: 200)
    }
}
