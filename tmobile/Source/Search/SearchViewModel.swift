//
//  SearchViewModel.swift
//  tmobile
//
//  Created by naga vineel golla on 4/23/21.
//

import Foundation
import UIKit

protocol SearchViewControllerProtocol: class {
    func didFinishFetch()
    func updateLoadingStatus(isloading: Bool)
}

class SearchViewModel {
    
    let networkManager: Network?
    var nextLink: String?
    var redditData: [ChildData] = []
    
    var isLoading: Bool = false {
        didSet { delegate?.updateLoadingStatus(isloading: isLoading) }
    }
    
    weak var delegate: SearchViewControllerProtocol?
    
    init(networkManager: Network) {
        self.networkManager = networkManager
        fetchData()
    }
    
    func fetchData() {
        isLoading = true
        self.networkManager?.fetchDataWith(nextLink: nextLink, onCompletion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.isLoading = false
                if let redditData = data,
                   let welcomeData = redditData.data {
                    self?.nextLink = welcomeData.after
                    if let child = welcomeData.children {
                        self?.removeEmptyData(data: child)
                    }
                }
            case .failure(let error):
                self?.isLoading = false
                print(error)
            }
        })
    }
    
    func removeEmptyData(data: [Child]) {
        for rData in data {
            if let redditData = rData.data, let _ = redditData.title, let _ = redditData.numComments, let _ = redditData.score, let imageUrl = redditData.thumbnail, let _ = redditData.thumbnailHeight, let _ = redditData.thumbnailWidth, imageUrl.hasPrefix("https") {
                self.redditData.append(redditData)
            }
        }
        self.delegate?.didFinishFetch()
    }
}
