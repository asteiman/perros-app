//
//  Error.swift
//  perros-app
//
//  Created by Alan Steiman on 10/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            // "The Internet connection appears to be offline."
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}
