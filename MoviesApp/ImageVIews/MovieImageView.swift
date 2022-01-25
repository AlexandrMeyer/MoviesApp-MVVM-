//
//  MovieImageView.swift
//  MoviesApp
//
//  Created by Александр on 17.12.21.
//

import UIKit

class MovieImageView: UIImageView {
    
    static let shared = MovieImageView()
    
    func fetchImageData(from url: String?) -> Data? {
        
        guard let url = url else { return nil }
        guard let url = URL(string: "https:\(url)") else {
            image = UIImage(systemName: "photo")
            return nil
        }

        guard let imageData = try? Data(contentsOf: url) else { return nil }
        
        return imageData
    }
    
    func fetchImage(from url: String) {
        
        guard let url = URL(string: "https:\(url)") else {
            image = UIImage(systemName: "photo")
            return
        }
        
        // Используем изображение из кеша, если оно там есть
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        // Если изображения нет, то грузим его из сети
        NetworkManager.shared.fetchPoster(from: url) { [unowned self] data, response in
            image = UIImage(data: data)
            saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    
    private func getCachedData(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return cachedResponse.data
        }
        return nil
    }
}
