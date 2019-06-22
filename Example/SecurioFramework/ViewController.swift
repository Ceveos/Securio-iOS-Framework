//
//  ViewController.swift
//  SecurioFramework
//
//  Created by Alex Casasola on 06/22/2019.
//  Copyright (c) 2019 Alex Casasola. All rights reserved.
//

import UIKit
import SecurioFramework

class ViewController: UIViewController {
    var securio: Securio?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize our IAP verifier
        do {
            let appInfo = AppInfo(
                appIdentifier: "50a96600-9434-11e9-9329-2f503c9b7e39",
                publicKey:
"""
-----BEGIN RSA PUBLIC KEY-----
MEgCQQC6g7JnS9TRic7GS4r+X9glYgb5j00+YeUUrQPinwTsDYDZhEj7xgZvSII2
sXcpl6HDBcoLVcECE9pgmue0U5OZAgMBAAE=
-----END RSA PUBLIC KEY-----
""",
                useSandbox: false)
            
            self.securio = try Securio(with: appInfo)
            self.securio!.validate(receipt: "{BASE-64 RECEIPT DATA}") { response in
                switch response.status {
                case .verified(_, _, _):
                    print("Validation successful!")
                    break;
                case .error(let reason, let message):
                    print("Validation error!")
                    switch reason {
                    case .configurationError:
                        print("Configuration error: \(message)")
                    case .apiLimitError:
                        print("We hit the API limit for this application")
                    case .genericError:
                        print("Generic error: \(message)")
                    case .notVerified:
                        print("The receipt is not verified!")
                    case .sanityCheckError:
                        print("We detected some spoofing")
                    }
                    break;
                }
            }
        } catch {
            // Can't validate IAP
            print("Error initializing Securio - ensure your public key is correct")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

