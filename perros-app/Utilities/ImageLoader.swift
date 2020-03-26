//
//  ImageLoader.swift
//  perros-app
//
//  Created by Alan Steiman on 16/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    private var cache: ImageCache?
    private let session: URLSession
    
    init(url: URL, cache: ImageCache? = nil, session: URLSession = .shared) {
        self.url = url
        self.cache = cache
        self.session = session
    }

    private var cancellable: AnyCancellable?
        
    func load() {
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        cancellable = session.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [unowned self] in self.saveToCache($0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func saveToCache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
}
