//
//  SecurioResponse.swift
//  SecurioClient
//
//  Created by Alex Casasola on 6/21/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation

/// What is returned when the framework verifies a receipt with the server
public struct SecurioResponse {
    
    /// The status of the receipt validation (either .verified or .error)
    public let status: SecurioStatus
    
}


/// What the status of a response was
///
/// - verified: The receipt was successfully verified, and can be trusted
/// - error: There was an error validating the receipt (check SecurioError for possibilities)
public enum SecurioStatus {
    case verified(signedHash: String, receipt: String, response: ServerResponse)
    case error(reason: SecurioError, message: String)
}

/// What the server responds to the Securio framework
public struct ServerResponse: Decodable {
    
    /// Is the receipt validated
    public let validated: Bool?
    
    /// Was there an error validating the receipt
    public let error: String?
    
    /// human-readable text that clarifies on error
    public let message: String?
    
    /// What is the signature to verify that the receipt was verified
    public let signature: String?
}

