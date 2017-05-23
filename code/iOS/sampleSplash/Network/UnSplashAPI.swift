//
//  UnSplashAPI.swift
//  UCSSplash
//
//  Created by Htain Lin Shwe on 20/5/17.
//  Copyright © 2017 comquas. All rights reserved.
//

import Foundation

struct endPoint {
    static let photo = "/photos"
}

class UnSplashAPI {
    
    let API = CQHTTP()
    let URL = "https://api.unsplash.com"
    
    init() {
        API.setHeader(key: "Authorization", value: "Client-ID f965dd8fdf1b7468a3e318e3a08beccdd9ee87118f00096bb7720efe436ea76c")
    }
    
    func getPhotos(completion: @escaping (((Array<UCSPhoto>)?) -> Void)) {
        
        _ = API.get(url: "\(URL)\(endPoint.photo)", completion: { (response) in
            
            var ucsPhotos: Array<UCSPhoto> = []
            
            guard let photos = response.result as? Array<Dictionary<String,Any>> else {
                completion(nil)
                return
            }
            
            for photo in photos {
                
                let unsplashPhoto = UCSPhoto()
                
                if let user = photo["user"] as? Dictionary<String,Any> {
                    if let username = user["name"] as? String {
                        unsplashPhoto.photographer = username
                    }
                }
                
                if let image = photo["urls"] as? Dictionary<String,Any> {
                    
                    if let small = image["small"] as? String {
                        unsplashPhoto.imageURL = small
                    }
                    
                    if let small = image["regular"] as? String {
                        unsplashPhoto.imageURL = small
                    }
                    
                }
                
                ucsPhotos.append(unsplashPhoto)
            }
            
            completion(ucsPhotos)
            
            
        })
        
    }
    
}
