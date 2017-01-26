//
//  MainVC+CollectionView.swift
//  Tour
//
//  Created by Trevin Wisaksana on 1/25/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

// Responsible for CollectionView setup
extension MainVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // nibFile references the Main cell nib file
        let nibFile = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        // Registers the nib file
        collectionView.register(nibFile, forCellWithReuseIdentifier: "postCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! MainCollectionViewCell
        
        return cell
        
    }
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Size of the cell
        return CGSize(width: self.view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Spacing between the cells
        return CGFloat(0)
    }
    
    
    
}
