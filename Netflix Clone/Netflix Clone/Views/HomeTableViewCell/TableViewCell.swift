//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by A on 13/05/2023.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    weak var delegate:passDataToTitlePreviewVC?
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    let collectionIdentifier = "CollectionViewCell"
    var titleArray:[Title] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollectionView.register(UINib(nibName: collectionIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionIdentifier)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
    }

    
    
}

extension TableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdentifier, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell() }
        guard let myURL = titleArray[indexPath.item].posterPath else {return UICollectionViewCell()}
        cell.setMyPosterImage(with: myURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myCollectionView.deselectItem(at: indexPath, animated: true)
        
        let model = titleArray[indexPath.item]
        let titleName = model.originalTitle ?? model.name ?? model.originalName ?? model.title ?? ""
        let titleSearch = titleName + " Trailer"
        Networking.shared.getTitlePreview(with: titleSearch) { result in
            switch result {
            case .success(let movie):
                self.delegate?.setupTitlePreview(title: titleName , overview: model.overview ?? "", webView: movie.id?.videoId ?? "")
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "story") as! TitlePreviewViewController
//                self.navigationcontroller
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    func passTitleArray(title:[Title]) {
        self.titleArray = title
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }
    
    
    
    
}
