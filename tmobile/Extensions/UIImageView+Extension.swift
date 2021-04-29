//
//  UIImageView.swift
//  tmobile
//
//  Created by naga vineel golla on 4/24/21.
//

import Foundation
import  UIKit

extension UIImageView {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()

    func downloaded(from link: String) {
        let imageUrl = link
        
        if let cacheImage = UIImageView.imageCache.object(forKey: link as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        guard let url = URL(string: imageUrl) else { return }
        
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            self.image = image
            
            DispatchQueue.main.async {
                UIImageView.imageCache.setObject(image, forKey: link as AnyObject)
            }
        }
    }
}
