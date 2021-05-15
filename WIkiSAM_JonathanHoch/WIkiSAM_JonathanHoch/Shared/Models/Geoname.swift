//
//  Geoname.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import Foundation

struct Geoname: Decodable {
    let title: String?
    let summary: String?
    let thumbnailImg: String?
    
    var thumbnailImgData: Data?
}
