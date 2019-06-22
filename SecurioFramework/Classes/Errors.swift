//
//  Errors.swift
//  Securio Client
//
//  Created by Alex Casasola on 6/19/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation

public enum SecurioError: Error {
    case sanityCheckError
    case genericError
    case notVerified
    case apiLimitError
    case configurationError
}
