//
//  TableViewCell.swift
//  Netflix Clone
//
//  Created by A on 13/05/2023.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
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
    
    func passTitleArray(title:[Title]) {
        self.titleArray = title
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }
    
    
}
