//
//  DemoVC.swift
//  ExamDemo
//
//  Created by MacBook Pro on 03/08/22.
//

import UIKit

class DemoVC: UIViewController {

    @IBOutlet weak var tableDemo: UITableView!
    
    internal var selectedCurrentPage : Int! = 0
    var autoCompleteCharacterCount = 0
    lazy var arrImages : [String] = ["Img1","Img2","Img3","Img4","Img5"]
    var arrImageItem : [ImageItem] = []
    var arrFilterImageItem : [ImageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        if let localData = self.readLocalFile(forName: "testData") {
            self.parse(jsonData: localData)
            self.tableDemo.reloadData()
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            let indTable = IndexPath(row: 0, section: 0)
            if let cell = self.tableDemo.cellForRow(at: indTable) as? ImagesCarouselTCell {
                cell.imagesCollectionView.reloadData()
                cell.imagesPageControl.currentPage = 0
            }
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
        
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }

    private func parse(jsonData: Data) {
        do {
            let imageItems: [ImageItem] = try JSONDecoder().decode([ImageItem].self, from: jsonData)
            print(imageItems.count)
            for item in imageItems {
                print("Title: ", item.itemImageInfo ?? "")
                
                self.arrImageItem.append(item)
                self.arrFilterImageItem.append(item)
            }
        } catch {
            print("decode error")
        }
    }
    
    func formatSubstring(subString: String) -> String {
        let formatted = String(subString.dropLast(autoCompleteCharacterCount)).lowercased().capitalized
        return formatted
    }
        
    func resetValues() {
        autoCompleteCharacterCount = 0
        let indTable = IndexPath(row: 0, section: 1)
        let cell = self.tableDemo.cellForRow(at: indTable) as! SearchTCell
        cell.searchTextfield.text = ""
        self.arrFilterImageItem.removeAll()
        for item in self.arrImageItem {
            self.arrFilterImageItem.append(item)
        }
        self.tableDemo.reloadData()
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                if self.tableDemo.frame.origin.y >= 0{
                    self.tableDemo.frame.origin.y -= 300
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.tableDemo.frame.origin.y += 300
            }
        }
    }
}

