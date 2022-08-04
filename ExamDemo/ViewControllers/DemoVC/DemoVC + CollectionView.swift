//
//  DemoVC + CollectionView.swift
//  ExamDemo
//
//  Created by MacBook Pro on 03/08/22.
//

import Foundation
import UIKit

extension DemoVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageItemCCell", for: indexPath) as! ImageItemCCell
    
        cell.imageItemBGImageView.image = UIImage(named: arrImages[indexPath.row])
        cell.imageItemLabel.text = "\(indexPath.row + 1)"
        return cell
    }
}

extension DemoVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 210)
    }
}

extension DemoVC : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let indTable = IndexPath(row: 0, section: 0)
            if let cell: ImagesCarouselTCell = self.tableDemo.cellForRow(at: indTable) as? ImagesCarouselTCell {
                let visibleRect = CGRect(origin: cell.imagesCollectionView.contentOffset, size: cell.imagesCollectionView.bounds.size)
                let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
                if let visibleIndexPath = cell.imagesCollectionView.indexPathForItem(at: visiblePoint) {
                    self.selectedCurrentPage = visibleIndexPath.row
                    cell.imagesPageControl.currentPage = visibleIndexPath.row
                    cell.imagesCollectionView.reloadData()
                }
            }
        }
    }
}

