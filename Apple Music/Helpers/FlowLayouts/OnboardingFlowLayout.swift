//
//  OnboardingFlowLayout.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 04.09.2022.
//

import UIKit

class OnboardingFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        
        self.itemSize = CGSize(width: width, height: height)
        
        self.sectionInsetReference = .fromSafeArea
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.scrollDirection = .horizontal
    }
}
