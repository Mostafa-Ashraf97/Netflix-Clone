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
        let width = searchCollectionView.bounds.width
        let itemsPerRow:CGFloat = 3
        let spacing: CGFloat = 10
        let availableWidth = width - spacing * (itemsPerRow + 1)
        let itemDimension = floor(availableWidth / itemsPerRow)
        
        return CGSize(width: itemDimension, height: itemDimension)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.searchCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchCollectionView.deselectItem(at: indexPath, animated: true)
        
        let model = searchedArray[indexPath.item]
        let titleName = model.originalTitle ?? model.name ?? model.originalName ?? model.title ?? ""
        let titleSearch = titleName + " Trailer"
        Networking.shared.getTitlePreview(with: titleSearch) { result in
            switch result {
            case .success(let movie):
//                self.delegate?.setupTitlePreview(title: titleName , overview: model.overview ?? "", webView: movie.id?.videoId ?? "")
                DispatchQueue.main.async {
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "story") as! TitlePreviewViewController

                    self.navigationController?.pushViewController(vc1, animated: true)

                    vc1.setupTitlePreview(title: titleName, overview: model.overview ?? "", webView: movie.id?.videoId ?? "")

                }
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "story") as! TitlePreviewViewController
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}
