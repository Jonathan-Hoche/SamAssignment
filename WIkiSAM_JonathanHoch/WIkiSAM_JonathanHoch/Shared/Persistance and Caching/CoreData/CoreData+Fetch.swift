//
//  CoreData+Fetch.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 15/05/2021.
//

import Foundation
import CoreData

extension CoreData {
    
    struct Fetch {
        private static let titleAttribute = "title"
        
        static func geonames(containing keyword: String) -> [Geoname] {
            let request: NSFetchRequest<CDGeoname> = CDGeoname.fetchRequest()
            let sortDescriptor: NSSortDescriptor = NSSortDescriptor(key: titleAttribute, ascending: true)
            let byTitleContainingKeywordPredicate = NSPredicate(format: "\(Fetch.titleAttribute) CONTAINS[cd] %@", keyword)
            
            request.predicate = byTitleContainingKeywordPredicate
            request.sortDescriptors = [sortDescriptor]
            
            do {
                let cdGeonames = try viewContext.fetch(request)
                let geonames = cdGeonames.map {Geoname.init(cdGeoname: $0)}
                return geonames
            } catch  {
                print ("There was an error fetching CDGeonames in CoreData")
                return []
            }
        }
    }
}

private extension Geoname {
    init(cdGeoname: CDGeoname) {
        self.title = cdGeoname.title
        self.summary = cdGeoname.summary
        self.thumbnailImg = cdGeoname.thumbnailImg
    }
}
