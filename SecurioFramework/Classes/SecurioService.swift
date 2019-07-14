//
//  SecurioAPI.swift
//  Securio Client
//
//  Created by Alex Casasola on 6/19/19.
//  Copyright © 2019 Alex Casasola. All rights reserved.
//

import Foundation
import Moya

/// Defining the API used by Moya to communicate with Securio
///
/// - validate: Validate a receipt with Securio
enum SecurioService {
    case validate(appInfo: AppInfo, receipt: String, uuid: String)
}

// MARK: - TargetType Protocol Implementation
extension SecurioService: TargetType {
    
    /// Base URL for the API calls
    var baseURL: URL { return URL(string: "https://api.securio.app/v1")! }
    
    /// What path to take for a given API call
    var path: String {
        switch self {
        case .validate(let appInfo, _, _):
            return "/validate/\(appInfo.appIdentifier)"
        }
    }
    
    /// What method to use for a given API call
    var method: Moya.Method {
        switch self {
            case .validate:
                return .post
        }
    }
    
    /// What should be sent as part of a given API call
    var task: Task {
        switch self {
        case let .validate(appInfo, receipt, uuid): // Always send parameters as JSON in request body
            return .requestParameters(parameters: [
                "receipt": receipt,
                "platform": "ios",
                "uuid": uuid,
                "sandbox": appInfo.sandbox], encoding: JSONEncoding.default)
        }
    }
    
    /// Sample response data for a given API call
    var sampleData: Data {
        switch self {
        case .validate(_, _, _):
            return """
{
    "status": true,
    "message": {
        "receipt": {
            "original_purchase_date_pst": "2015-11-23 08:32:27 America/Los_Angeles",
            "purchase_date_ms": "1448296347138",
            "unique_identifier": "e47425df7fb6ab8c3c7e5730c3a7eb5b6563823d",
            "original_transaction_id": "1000000181492557",
            "bvrs": "3",
            "transaction_id": "1000000181492557",
            "quantity": "1",
            "unique_vendor_identifier": "5C275B5A-3E66-4026-9523-845B225755FC",
            "item_id": "1061557484",
            "product_id": "purchaser.consumableFeature",
            "purchase_date": "2015-11-23 16:32:27 Etc/GMT",
            "original_purchase_date": "2015-11-23 16:32:27 Etc/GMT",
            "purchase_date_pst": "2015-11-23 08:32:27 America/Los_Angeles",
            "bid": "com.es.Purchaser",
            "original_purchase_date_ms": "1448296347138"
        },
        "status": 0,
        "sandbox": true,
        "service": "apple"
    },
    "signature": "rggyUerdGnGZ4egPX+kuipPpNo6hd2zIoQvzEmloD2Nm4x+8ek1vTbnOyE5USq3j0vu5y8pWKKoykuGlVjU1Lg=="
}
""".utf8Encoded
        }
    }
    
    /// Headers to send to the API
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

