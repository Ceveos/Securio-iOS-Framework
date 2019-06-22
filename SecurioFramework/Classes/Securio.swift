//
//  Securio_Client.swift
//  Securio Client
//
//  Created by Alex Casasola on 6/18/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation
import SwiftyRSA
import Moya

public class Securio {
    let provider = MoyaProvider<SecurioService>()
    let appInfo: AppInfo
    let publicKey: PublicKey
    
    public init(with appInfo: AppInfo) throws {
        
        do
        {
            self.appInfo = appInfo;
            let sanitizedKey = self.appInfo.publicKey.replacingOccurrences(of: "(-----.+-----|\\n)", with: "", options: .regularExpression)
            self.publicKey = try PublicKey(base64Encoded: sanitizedKey)
            try self.sanityCheck()
        } catch SecurioError.sanityCheckError {
            // todo: log hack attempt at api
            throw SecurioError.sanityCheckError
        }
    }
    
    /// Verify that the app is not misbehaving (jailbreak tweaks such as Flex)
    private func sanityCheck() throws {
        // Create a fake appinfo object
        // Ensure that the constructor args or return values aren't being forcibly overridden with other values
        let fakeString = "test"
        let fakeAppInfo = AppInfo(appIdentifier: fakeString, publicKey: fakeString, useSandbox: false)
        if fakeAppInfo.appIdentifier != fakeString
            || fakeAppInfo.publicKey != fakeString
            || fakeAppInfo.sandbox == true {
            throw SecurioError.sanityCheckError
        }
        
        // Try to validate a server response
        let fakeServerResponse = ServerResponse(validated: false, error: "NOT_VERIFIED", message: nil, signature: fakeString)
        if (fakeServerResponse.validated == true
            || fakeServerResponse.signature != fakeString) {
            throw SecurioError.sanityCheckError
        }
        
        // Try to see if we can return a sanity check error
        let fakeResponse = SecurioResponse(status: .error(reason: SecurioError.sanityCheckError, message: "Test"))
        if case SecurioStatus.verified = fakeResponse.status {
            throw SecurioError.sanityCheckError
        }
        
        // Try to validate a fake hash, if it comes back positive
        // then we can't trust this
        if validate(data: "fake", with: "fake") {
            throw SecurioError.sanityCheckError
        }
    }
    
    public func validate(data: String, with signature: String) -> Bool {
        do {
            let clear = try ClearMessage(string: data, using: .utf8)
            let signature = try Signature(base64Encoded: signature)
            return try clear.verify(with: self.publicKey, signature: signature, digestType: .sha256)
        } catch {
            return false
        }
    }
    
    public func validate(receipt: String, completion: @escaping (SecurioResponse) -> Void) {

        self.provider.request(.validate(appInfo: self.appInfo, receipt: receipt)) { result in
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ServerResponse.self, from: moyaResponse.data)
                    let parsedResponse: SecurioResponse
                    
                    if (response.validated ?? false) {
                        if self.validate(data: receipt, with: response.signature ?? "") {
                            parsedResponse = SecurioResponse(status: .verified(signedHash: response.signature ?? "", receipt: receipt, response: response))
                        } else {
                            parsedResponse = SecurioResponse(status: .error(reason: .sanityCheckError, message: "Spoof attempt detected"))
                        }
                    } else {
                        switch(response.error ?? "GENERIC_ERROR") {
                        case "CONFIGURATION_ERROR":
                            parsedResponse = SecurioResponse(status: .error(reason: .configurationError, message: response.message ?? ""))
                        case "API_LIMIT_ERROR":
                            parsedResponse = SecurioResponse(status: .error(reason: .apiLimitError, message: response.message ?? ""))
                        case "NOT_VERIFIED":
                            parsedResponse = SecurioResponse(status: .error(reason: .notVerified, message: response.message ?? ""))
                        case "GENERIC_ERROR":
                            fallthrough
                        default:
                            parsedResponse = SecurioResponse(status: .error(reason: .genericError, message: response.message ?? ""))
                        }
                    }
                    completion(parsedResponse)
                }
                catch {
                    completion(SecurioResponse(status: .error(reason: .genericError, message: "Validation error occured")))
                }
            case .failure(_):
                completion(SecurioResponse(status: .error(reason: .notVerified, message: "Receipt not verified")))
            }
            
        }
    }
    
}
