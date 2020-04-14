//
//  ImageCache.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCache {
    subscript(_: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()

    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
