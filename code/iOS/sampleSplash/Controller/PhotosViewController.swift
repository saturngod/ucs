//
//  PhotosViewController.swift
//  UCSSplash
//
//  Created by Htain Lin Shwe on 20/5/17.
//  Copyright © 2017 comquas. All rights reserved.
//

import UIKit
import PKHUD
class PhotosViewController: UITableViewController {
    
    @IBOutlet var dataSource: PhotoListDataSource!
    
    var loaded: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Unsplash Photos"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !loaded {
            loadAllPhoto()
            loaded = true
        }
    }
    
    func loadAllPhoto() {
        
        HUD.show(.progress)
        
        API.getPhotos { (response) in
            
            DispatchQueue.main.async {
                HUD.hide()
            }
            
            
            guard let response = response else {
                return
            }
            self.dataSource.data = response

            DispatchQueue.main.async {
             self.tableView.reloadData()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
//    func loadAllPhoto() {
//        
//        HUD.show(.progress)
//        
//        API.getPhotos { (response) in
//            
//            DispatchQueue.main.async {
//                HUD.hide()
//            }
//            guard let response = response else {
//                return
//            }
//            self.dataSource.data = response
//            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let d = self.dataSource.data[indexPath.row]
//        self.title = "Back"
//        self.performSegue(withIdentifier: "showImage", sender: d)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showImage" {
//            if let vc = segue.destination as? PhotoDetailViewController {
//                vc.ucsphoto = sender as? UCSPhoto
//            }
//        }
//    }
}
