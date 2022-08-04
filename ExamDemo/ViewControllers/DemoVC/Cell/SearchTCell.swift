//
//  SearchTCell.swift
//  ExamDemo
//
//  Created by MacBook Pro on 04/08/22.
//

import UIKit

class SearchTCell: UITableViewCell {

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchPlaceholderStackView: UIStackView!
    @IBOutlet weak var searchImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
