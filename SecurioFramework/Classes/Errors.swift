//
//  Errors.swift
//  Securio Client
//
//  Created by Alex Casasola on 6/19/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation

/// A list of errors that may be returned when a receipt validation fails
///
/// - sanityCheckError: The user is attempting to spoof or hack the app to fool Securio into thinking a receipt is legitimate
/// - genericError: When an unknown error occurs. Check the message that comes along with this for more information
/// - notVerified: When the receipt is successfully checked, but apple reported as unverified (not a valid receipt)
/// - apiLimitError: If you don't have any more resources on Securio to verify this receipt (might need to upgrade your plan on Securio)
/// - configurationError: The application ID, public key, or your apple shared key is wrong. Please check your settings
public enum SecurioError: Error {
    case sanityCheckError
    case genericError
    case notVerified
    case apiLimitError
    case configurationError
}
