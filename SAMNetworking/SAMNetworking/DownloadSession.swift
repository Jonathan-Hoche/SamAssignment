//
//  DownloadSession.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import Foundation

public protocol DownloadSessionDelegate: class {
    func didFinishDownloading(data: Data?, for info: DownloadSession.Info)
}

public class DownloadSession: NSObject {
    
    public struct Info {
        public let identifier: String
        public let index: Int?
        public let uuid: UUID?
        
        public init(identifier: String, index: Int? = nil, uuid: UUID? = nil) {
            self.identifier = identifier
            self.index = index
            self.uuid = uuid
        }
    }
    
    let info: Info
    private let url: URL
    private weak var delegate: DownloadSessionDelegate?
    
    private var downloadTask: URLSessionDownloadTask?
    
    public init(url: URL, info: Info, delegate: DownloadSessionDelegate) {
        self.url = url
        self.info = info
        self.delegate = delegate
    }
    
    public func resume() {
        if downloadTask == nil {
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
            downloadTask = session.downloadTask(with: url)
        }
        downloadTask?.resume()
    }
    
    public func cancel() {
        downloadTask?.cancel()
        downloadTask = nil
    }
}

extension DownloadSession: URLSessionDownloadDelegate {
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data = try? Data(contentsOf: location)
        delegate?.didFinishDownloading(data: data, for: info)
    }
}
