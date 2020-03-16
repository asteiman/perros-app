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
    
    init(url: URL) {
        self.url = url
    }

    private var cancellable: AnyCancellable?
        
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
