//
//  AppInfo.swift
//  Securio Client
//
//  Created by Alex Casasola on 6/19/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation

public struct AppInfo {
    public let appIdentifier: String
    public let publicKey: String
    public let sandbox: Bool
    
    public init(appIdentifier: String, publicKey: String, useSandbox sandbox: Bool) {
        self.appIdentifier = appIdentifier
        self.publicKey = publicKey
        self.sandbox = sandbox
        
    }
    
}
