//
//  WikipediaSearchPresenter.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import Foundation
import SAMNetworking

protocol WikipediaSearchPresenterDelegate: class {
    func geonamesDidUpdate()
    func requestWikiGeonamesFailed()
    func didDownloadThumbnailImageForCell(at index: Int)
}

class WikipediaSearchPresenter {
    
    private let apiService = APIService()
    private let imagesDownloader = ImagesDownloader()
    private let imagesCache = ImagesCache()
    
    weak var delegate: WikipediaSearchPresenterDelegate?
    
    private var currentKeyword =  ""
    private var geonamesUUID = UUID()
    var geonames = [Geoname]() {
        didSet {
            geonamesUUID = UUID()
            delegate?.geonamesDidUpdate()
        }
    }
    
    var searchMode = SearchMode.internet {
        didSet {
            geonames.removeAll()
            getGeonames(with: currentKeyword)
        }
    }
    
    func getGeonames(with keyword: String) {
        currentKeyword = keyword
        apiService.cancelRequestWikiGeonames()
        guard keyword.count > 0 else {
            geonames.removeAll()
            return
        }
        
        switch searchMode {
        case .internet:
            struct GeonamesData: RequestDataType {
                let geonames: [Geoname]
            }
            
            apiService.requestWikiGeonames(with: keyword, requestDataType: GeonamesData.self) { [weak self] (geonamesData, error) in
                if let geonames = geonamesData?.geonames {
                    self?.geonames = geonames
                    CoreData.Add.geonames(geonames)
                } else {
                    if error?.localizedDescription != "cancelled" {
                        self?.delegate?.requestWikiGeonamesFailed()
                    }
                }
            }
        case .local:
            geonames = CoreData.Fetch.geonames(containing: keyword)
        }
    }
    
    func fetchImageForGeoname(at index: Int) {
        if geonames.indices.contains(index),
           geonames[index].thumbnailImgData == nil,
           let urlString = geonames[index].thumbnailImg {
            if let cachedImageData = imagesCache.getImage(for: urlString) {
                geonames[index].thumbnailImgData =  Data(referencing: cachedImageData)
                delegate?.didDownloadThumbnailImageForCell(at: index)
            } else if let imageUrl = URL(string: urlString) {
                let info = DownloadSession.Info(identifier: urlString, index: index, uuid: geonamesUUID)
                imagesDownloader.downloadImage(at: imageUrl, info: info, downloadSessionDelegate: self)
            }
        }
    }
}

extension WikipediaSearchPresenter: DownloadSessionDelegate {
    
    func didFinishDownloading(data: Data?, for info: DownloadSession.Info) {
        if info.uuid == geonamesUUID,
            let data = data,
            let index = info.index, geonames.indices.contains(index) {
            DispatchQueue.main.async {
                self.imagesCache.cache(data as NSData, for: info.identifier)
                self.geonames[index].thumbnailImgData = data
                self.delegate?.didDownloadThumbnailImageForCell(at: index)
            }
        }
    }
}

extension WikipediaSearchPresenter {
    enum SearchMode {
        case internet
        case local
        
        mutating func toggle() {
            switch self {
            case .internet: self = .local
            case .local: self = .internet
            }
        }
    }
}
