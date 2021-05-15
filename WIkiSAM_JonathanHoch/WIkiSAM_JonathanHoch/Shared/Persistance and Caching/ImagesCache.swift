//
//  ImagesCache.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 15/05/2021.
//

import UIKit

class ImagesCache: NSCache<NSString, NSData> {
    
    func cache(_ image: NSData, for key: String) {
        setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> NSData? {
        return object(forKey: key as NSString)
    }
}
