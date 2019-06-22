//
//  String.swift
//  Securio Client
//
//  Created by Alex Casasola on 6/20/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation

public extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
