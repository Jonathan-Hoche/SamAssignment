//
//  APIService.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import Foundation

public class APIService {
    
    public init() {}
    
    private let request = Request()
    private let wikiGeonamesURLSession = URLSession(configuration: URLSessionConfiguration.default)
    private var wikiGeonamesDataTask: URLSessionDataTask?

    public func requestWikiGeonames<T: RequestDataType>(with keyword: String,
                                                        requestDataType: T.Type,
                                                        completion: @escaping (_ geonamesData: T?, _ error: Error?) -> Void) {
        cancelRequestWikiGeonames()
        
        if let escapedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
           let url = URL(string: "http://api.geonames.org/wikipediaSearchJSON?q=\(escapedKeyword)&maxRows=10&username=MennySam") {
            wikiGeonamesDataTask = wikiGeonamesURLSession.dataTask(with: url, completionHandler: { (data, response, error) in
                let parsedInfo = self.request.parse(requestDataType: requestDataType, data: data, error: error)
                DispatchQueue.main.async {
                    completion(parsedInfo.data, parsedInfo.error)
                }
            })
            
            wikiGeonamesDataTask?.resume()
        }
    }
    
    public func cancelRequestWikiGeonames() {
        wikiGeonamesDataTask?.cancel()
        wikiGeonamesDataTask = nil
    }
}
