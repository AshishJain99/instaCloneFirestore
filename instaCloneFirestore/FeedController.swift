//
//  FeedController.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 26/08/23.
//

import UIKit

private let reuseIdentifier = "cell"


class FeedController:UICollectionViewController{
    
    var data = [1,2,3,4,5,6]
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}


// MARK: UICollectionViewDataSource

extension FeedController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        return cell
    }
}


extension FeedController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width+8+40+8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
    
    
}
