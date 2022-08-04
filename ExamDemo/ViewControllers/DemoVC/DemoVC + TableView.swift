//
//  DemoVC + TableView.swift
//  ExamDemo
//
//  Created by MacBook Pro on 03/08/22.
//

import Foundation
import UIKit

extension DemoVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 250.0
            } else {
                return 0
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 75.0
            } else {
                return 0
            }
        } else if indexPath.section == 2 {
            return 85.0
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return arrFilterImageItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell : ImagesCarouselTCell = tableView.dequeueReusableCell(withIdentifier: "ImagesCarouselTCell")! as! ImagesCarouselTCell
            cell.imagesCollectionView.delegate = self
            cell.imagesCollectionView.dataSource = self
            cell.imagesPageControl.numberOfPages = arrImages.count
            cell.imagesPageControl.translatesAutoresizingMaskIntoConstraints = false
           
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            return cell
        } else if indexPath.section == 1 {
            let cell : SearchTCell = tableView.dequeueReusableCell(withIdentifier: "SearchTCell")! as! SearchTCell
            cell.searchTextfield.delegate = self
            cell.searchImageView.tintColor = .darkGray
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            return cell
        } else {
            let cell : ItemTCell = tableView.dequeueReusableCell(withIdentifier: "ItemTCell")! as! ItemTCell
            cell.itemImageView.backgroundColor = .darkGray
            cell.itemImageView.image = UIImage(named: self.arrFilterImageItem[indexPath.row].imageName ?? "")
            cell.itemInfoLabel.text = self.arrFilterImageItem[indexPath.row].itemImageInfo ?? ""
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            return cell
        }
    }
    
    
    @IBAction func pageControlValueChangeAction(_ sender: UIPageControl) {
        selectedCurrentPage = sender.currentPage
    }
    
    @IBAction func pageControlImagesAction(_ sender: UIPageControl) {
        DispatchQueue.main.async {
            self.selectedCurrentPage = sender.currentPage
            let cell = self.tableDemo.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImagesCarouselTCell
            cell.imagesCollectionView.scrollToItem(at: IndexPath(row: self.selectedCurrentPage, section: 0), at: .centeredHorizontally, animated: true)
            cell.imagesCollectionView.reloadData()
        }
    }
}
