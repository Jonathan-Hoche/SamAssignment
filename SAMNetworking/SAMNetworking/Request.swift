//
//  Request.swift
//  SAMNetworking
//
//  Created by Jonathan Hoche on 15/05/2021.
//

import Foundation

public protocol RequestDataType: Decodable {}

struct Request {
    
    func parse<T: RequestDataType>(requestDataType: T.Type, data: Data?, error: Error?) -> (data: T?, error: Error?) {
        if let data = data {
            do {
                let data = try JSONDecoder().decode(requestDataType.self, from: data)
                return(data, nil)
            } catch {
                return (nil, error)
            }
        } else {
            return (nil, error)
        }
    }
}
