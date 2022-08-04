//
//  DemoVC + TextField.swift
//  ExamDemo
//
//  Created by MacBook Pro on 04/08/22.
//

import Foundation
import UIKit

extension DemoVC : UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let indTable = IndexPath(row: 0, section: 1)
        let cell = self.tableDemo.cellForRow(at: indTable) as! SearchTCell
        if textField.text == "" {
            cell.searchPlaceholderStackView.isHidden = false
        } else {
            cell.searchPlaceholderStackView.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let indTable = IndexPath(row: 0, section: 1)
        let cell = self.tableDemo.cellForRow(at: indTable) as! SearchTCell
        cell.searchPlaceholderStackView.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var subString = (textField.text!.capitalized as NSString).replacingCharacters(in: range, with: string) // 2
        subString = formatSubstring(subString: subString)
                
        if subString.count == 0 {
            resetValues()
        } else {
            print("SubString \(subString)")
            self.arrFilterImageItem.removeAll()
            for item in self.arrImageItem {
                if item.itemImageInfo != nil {
                    if (item.itemImageInfo!.contains(subString)) {
                        self.arrFilterImageItem.append(item)
                    }
                }
            }
            self.tableDemo.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
        return true
    }
}
