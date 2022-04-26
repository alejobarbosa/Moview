//
//  UIImageViewExtension.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation
import UIKit

///Value to save the image in cache when is scrolling table view
var imageCache = NSCache<AnyObject,AnyObject>()
extension UIImageView {
    
    func loadFromURL(_ urlStrign: String){
        if let image = imageCache.object(forKey: urlStrign as NSString) as? UIImage {
            self.image = image
            return
        }
        guard let url = URL(string: urlStrign) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url),
                let loadedImage = UIImage(data: imageData){
                DispatchQueue.main.async {
                    imageCache.setObject(loadedImage, forKey: urlStrign as NSString)
                    self?.image = loadedImage
                }
            }
        }
    }
    
}
