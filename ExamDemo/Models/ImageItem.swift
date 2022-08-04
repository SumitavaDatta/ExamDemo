//
//  ImageItem.swift
//  ExamDemo
//
//  Created by MacBook Pro on 04/08/22.
//

import UIKit

class ImageItem: Codable {
    var id: Int?
    var imageName: String?
    var itemImageInfo: String?

    init(id : Int, imageName : String, itemImageInfo : String){
        self.id = id
        self.imageName = imageName
        self.itemImageInfo = itemImageInfo
    }
}
