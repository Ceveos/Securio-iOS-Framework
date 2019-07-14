//
//  AppInfo.swift
//  Securio Client
//
//  Created by Alex Casasola on 6/19/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation

/// Structure that encompasses all the information needed to communicate with Securio
public struct AppInfo {
    /// Unique identifier used to identify the application being used on Securio
    public let appIdentifier: String
    
    /// Public Key is used to verify signed data that comes back from Securio.
    /// The Private Key is held on the server, and is identified via the application identifier
    public let publicKey: String
    
    /// Allows you to force Securio to only validate the receipt against the sandbox server.
    /// If this is set to false, Securio will still check the sandbox server if the production server fails.
    public let sandbox: Bool
    
    /// Initializes AppInfo with everything you need to begin server-side validation
    ///
    /// - Parameters:
    ///   - appIdentifier: Application Identifier (found as a GUID in the Securio Dashboard)
    ///   - publicKey: Public Key used to verify signed data from the server
    ///   - sandbox: Force Securio to **only** check Apple's sandbox server
    public init(appIdentifier: String, publicKey: String, useSandbox sandbox: Bool) {
        self.appIdentifier = appIdentifier
        self.publicKey = publicKey
        self.sandbox = sandbox
    }
    
}
