//
//  SecurioResponse.swift
//  SecurioClient
//
//  Created by Alex Casasola on 6/21/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation

// What we return from the framework to user application
public struct SecurioResponse {
    public let status: SecurioStatus
    
}

public enum SecurioStatus {
    case verified(signedHash: String, receipt: String, response: ServerResponse)
    case error(reason: SecurioError, message: String)
}

// What the server responds to the framework
public struct ServerResponse: Decodable {
    public let validated: Bool?
    public let error: String?
    public let message: String?
    public let signature: String?
}

