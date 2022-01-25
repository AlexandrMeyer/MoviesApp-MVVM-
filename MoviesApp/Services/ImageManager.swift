//
//  ImageManager.swift
//  MoviesApp
//
//  Created by Александр on 30.12.21.
//

import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}

    func fetchImageData(from url: String?) -> Data? {
        guard let url = URL(string: "https:\(url ?? "")") else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        
        return imageData
    }
}

