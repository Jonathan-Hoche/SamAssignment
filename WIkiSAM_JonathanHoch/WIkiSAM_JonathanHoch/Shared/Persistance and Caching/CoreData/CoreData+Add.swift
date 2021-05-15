//
//  CoreData+Add.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 15/05/2021.
//

import Foundation
import CoreData
import SAMNetworking

extension CoreData {
    
    struct Add {
        static func geonames(_ geonames: [Geoname]) {
            viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
             for geoname in geonames {
                let cdGeoname = CDGeoname(context: viewContext)
                cdGeoname.title = geoname.title
                cdGeoname.summary = geoname.summary
                cdGeoname.thumbnailImg = geoname.thumbnailImg
            }
            
            saveContext()
        }
    }
}
