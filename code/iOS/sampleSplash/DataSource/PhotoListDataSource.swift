//
//  PhotoListDataSource.swift
//  UCSSplash
//
//  Created by Htain Lin Shwe on 20/5/17.
//  Copyright © 2017 comquas. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoListDataSource: NSObject, UITableViewDataSource {
    
    var data: Array<UCSPhoto> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageViewCell
        
        let photo = data[indexPath.row]
        
        let url = URL(string: photo.imageURL)
        
        cell.unsplashPhoto.kf.setImage(with: url)
        cell.photographerLabel.text = photo.photographer
        return cell
        
        
    }
    
}
