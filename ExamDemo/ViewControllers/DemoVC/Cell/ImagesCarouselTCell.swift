//
//  ImagesCarouselTCell.swift
//  ExamDemo
//
//  Created by MacBook Pro on 04/08/22.
//

import UIKit

class ImagesCarouselTCell: UITableViewCell {
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imagesPageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
