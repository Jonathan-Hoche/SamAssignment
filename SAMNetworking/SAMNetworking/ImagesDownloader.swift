//
//  ImageDownloader.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import Foundation

public struct ImagesDownloader {
    
    public init() {}
    
    public func downloadImage(at url: URL, info: DownloadSession.Info, downloadSessionDelegate: DownloadSessionDelegate) {
        DispatchQueue.global(qos: .background).async {
            let downloadSession = DownloadSession(url: url, info: info, delegate: downloadSessionDelegate)
            downloadSession.resume()
        }
    }
}
