//
//  Network.swift
//  tmobile
//
//  Created by naga vineel golla on 4/23/21.
//

import Foundation
import UIKit

protocol Network {
    func fetchDataWith(nextLink: String?, onCompletion : @escaping (Result<Welcome?,Error>) -> Void)
}

class NetworkManager: Network {
    
    static let shared = NetworkManager()
    
    func fetchDataWith(nextLink: String?, onCompletion : @escaping (Result<Welcome?,Error>) -> Void) {
        
        var url = Constants.redditUrl
        if let nextLink = nextLink, !nextLink.isEmpty {
            url = url + "?after=" + nextLink
        }
        
        guard let stringUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: stringUrl, completionHandler: { data, urlResponse, error in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Welcome.self, from: data)
                        onCompletion(.success(response))
                    } catch let error {
                        onCompletion(.failure(error))
                    }
                }
        }).resume()
    }
}
