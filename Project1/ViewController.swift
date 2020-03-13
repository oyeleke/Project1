//
//  ViewController.swift
//  Project1
//
//  Created by user on 13/01/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                //this is a picture
                pictures.append(item)
            }
        }
        pictures = pictures.sorted{$0 < $1}
        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            let navTitle = returnModifiedTitle(forImageWithIndex: indexPath.row)
            vc.modifiedTitle = navTitle
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func returnModifiedTitle(forImageWithIndex index: Int) -> String {
        return "Picture \(index + 1) of \(pictures.count)"
    }
}

