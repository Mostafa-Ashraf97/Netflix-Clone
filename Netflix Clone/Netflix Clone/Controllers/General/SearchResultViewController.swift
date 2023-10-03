//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by A on 24/05/2023.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var searchedArray:[Title] = []
    var vc1: TitlePreviewViewController?
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        searchCollectionView.register(
            UINib(nibName: CollectionViewCell.cellIdentifier,bundle: nil),forCellWithReuseIdentifier: CollectionViewCell.cellIdentifier
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
        let width = searchCollectionView.bounds.width
        let itemsPerRow:CGFloat = 3
        let spacing: CGFloat = 10
        let availableWidth = width - spacing * (itemsPerRow + 1)
        let itemDimension = floor(availableWidth / itemsPerRow)
        
        return CGSize(width: itemDimension, height: itemDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = searchedArray[indexPath.item]
        let titleName = model.originalTitle ?? model.name ?? model.originalName ?? model.title ?? ""
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        DispatchQueue.main.async {
            guard let vc1 = storyboard.instantiateViewController(withIdentifier: "story") as? TitlePreviewViewController else { return }
            vc1.titleName = titleName
            vc1.model = model
            //        self.present(vc1, animated: true)
            self.presentingViewController?.navigationController?.pushViewController(vc1, animated: true)
        }
    }
}
