// https://github.com/Quick/Quick

import Quick
import Nimble
import SecurioFramework

class TableOfContentsSpec: QuickSpec {
    let pubKey = """
MEgCQQC6g7JnS9TRic7GS4r+X9glYgb5j00+YeUUrQPinwTsDYDZhEj7xgZvSII2
sXcpl6HDBcoLVcECE9pgmue0U5OZAgMBAAE=
"""
    let wrongPubKey = """
MEgCQQCvqQoKjInjDRaIxhEuJIq5Rrgw1tuv9A/D9yJ6ceT58qR7wmNArFj5wHQg
80W5sO5OIhihaSr3KNhaV+WhH2edAgMBAAE=
"""
    let errorPubKey = """
MEgCQQCvqQokjInjDRaIxhEuJIq5Rrgw1tuv9A/D9yJ6ceT58qR7wmNArFj5wHQg
80W5sO5OIhihaSr3KNhaV+whH2eAgMBAAE=
"""
    let sandboxReceipt: String = "eyJzaWduYXR1cmUiID0gIkFoaHEwbmFxaG01ci8wSUNuYk9hVThCeVBLNkRja2ZsanRCMDNnZUh4dk0ybEVjVkdqK2NVM1lnWGZ0RkZCZ2lFYkR1NGdoYXFVWFRqRzlpc25Zeit6VWFhTXRUZDJ6YnNLbFhIMitzYm1ZaC9tY2M2eWt3dVFkaFZsOWZKYkxNaFVXWHNTUlIxVlVjQlE4TkxjVGg5ZHNXOTVTREcxdG9DQk45cWM0L01CZlVBQUFEVnpDQ0ExTXdnZ0k3b0FNQ0FRSUNDQnVwNCtQQWhtL0xNQTBHQ1NxR1NJYjNEUUVCQlFVQU1IOHhDekFKQmdOVkJBWVRBbFZUTVJNd0VRWURWUVFLREFwQmNIQnNaU0JKYm1NdU1TWXdKQVlEVlFRTERCMUJjSEJzWlNCRFpYSjBhV1pwWTJGMGFXOXVJRUYxZEdodmNtbDBlVEV6TURFR0ExVUVBd3dxUVhCd2JHVWdhVlIxYm1WeklGTjBiM0psSUVObGNuUnBabWxqWVhScGIyNGdRWFYwYUc5eWFYUjVNQjRYRFRFME1EWXdOekF3TURJeU1Wb1hEVEUyTURVeE9ERTRNekV6TUZvd1pERWpNQ0VHQTFVRUF3d2FVSFZ5WTJoaGMyVlNaV05sYVhCMFEyVnlkR2xtYVdOaGRHVXhHekFaQmdOVkJBc01Fa0Z3Y0d4bElHbFVkVzVsY3lCVGRHOXlaVEVUTUJFR0ExVUVDZ3dLUVhCd2JHVWdTVzVqTGpFTE1Ba0dBMVVFQmhNQ1ZWTXdnWjh3RFFZSktvWklodmNOQVFFQkJRQURnWTBBTUlHSkFvR0JBTW1URXVMZ2ppbUx3Ukp4eTFvRWYwZXNVTkRWRUllNndEc25uYWwxNGhOQnQxdjE5NVg2bjkzWU83Z2kzb3JQU3V4OUQ1NTRTa01wK1NheWc4NGxUYzM2MlV0bVlMcFduYjM0bnF5R3g5S0JWVHk1T0dWNGxqRTFPd0Mrb1RuUk0rUUxSQ21lTnhNYlBaaFM0N1QrZVp0REVoVkI5dXNrMytKTTJDb2dmd283QWdNQkFBR2pjakJ3TUIwR0ExVWREZ1FXQkJTSmFFZU51cTlEZjZaZk42OEZlK0kydTIyc3NEQU1CZ05WSFJNQkFmOEVBakFBTUI4R0ExVWRJd1FZTUJhQUZEWWQ2T0tkZ3RJQkdMVXlhdzdYUXd1UldFTTZNQTRHQTFVZER3RUIvd1FFQXdJSGdEQVFCZ29xaGtpRzkyTmtCZ1VCQkFJRkFEQU5CZ2txaGtpRzl3MEJBUVVGQUFPQ0FRRUFlYUpWMlU1MXJ4ZmNxQUFlNUMyL2ZFVzhLVWw0aU80bE11dGE3TjZYelAxcFpJejFOa2tDdElJd2V5Tmo1VVJZSEsrSGpSS1NVOVJMZ3VObDBua2Z4cU9iaU1ja3dSdWRLU3E2OU5JbnJaeUNENjZSNEs3N25iOWxNVEFCU1NZbHNLdDhvTnRsaGdSLzFralNTUlFjSGt0c0RjU2lRR0tNZGtTbHA0QXlYZjd2bkhQQmU0eUN3WVYyUHBTTjA0a2JvaUozcEJseHNHd1YvWmxMMjZNMnVlWUhLWUN1WGhkcUZ3eFZnbTUyaDNvZUpPT3Qvdlk0RWNRcTdlcUhtNm0wM1o5YjdQUnpZTTJLR1hIRG1PTWs3dkRwZU1WbExEUFNHWXoxK1Uzc0R4SnplYlNwYmFKbVQ3aW16VUtmZ2dFWTd4eGY0Y3pmSDB5ajV3TnpTR1RPdlE9PSI7ICJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUxTFRFeExUSXpJREE0T2pNeU9qSTNJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdWeUlpQTlJQ0psTkRjME1qVmtaamRtWWpaaFlqaGpNMk0zWlRVM016QmpNMkUzWldJMVlqWTFOak00TWpOa0lqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2YmkxcFpDSWdQU0FpTVRBd01EQXdNREU0TVRRNU1qVTFOeUk3Q2draVluWnljeUlnUFNBaU15STdDZ2tpZEhKaGJuTmhZM1JwYjI0dGFXUWlJRDBnSWpFd01EQXdNREF4T0RFME9USTFOVGNpT3dvSkluRjFZVzUwYVhSNUlpQTlJQ0l4SWpzS0NTSnZjbWxuYVc1aGJDMXdkWEpqYUdGelpTMWtZWFJsTFcxeklpQTlJQ0l4TkRRNE1qazJNelEzTVRNNElqc0tDU0oxYm1seGRXVXRkbVZ1Wkc5eUxXbGtaVzUwYVdacFpYSWlJRDBnSWpWRE1qYzFRalZCTFRORk5qWXROREF5TmkwNU5USXpMVGcwTlVJeU1qVTNOVFZHUXlJN0Nna2ljSEp2WkhWamRDMXBaQ0lnUFNBaWNIVnlZMmhoYzJWeUxtTnZibk4xYldGaWJHVkdaV0YwZFhKbElqc0tDU0pwZEdWdExXbGtJaUE5SUNJeE1EWXhOVFUzTkRnMElqc0tDU0ppYVdRaUlEMGdJbU52YlM1bGN5NVFkWEpqYUdGelpYSWlPd29KSW5CMWNtTm9ZWE5sTFdSaGRHVXRiWE1pSUQwZ0lqRTBORGd5T1RZek5EY3hNemdpT3dvSkluQjFjbU5vWVhObExXUmhkR1VpSUQwZ0lqSXdNVFV0TVRFdE1qTWdNVFk2TXpJNk1qY2dSWFJqTDBkTlZDSTdDZ2tpY0hWeVkyaGhjMlV0WkdGMFpTMXdjM1FpSUQwZ0lqSXdNVFV0TVRFdE1qTWdNRGc2TXpJNk1qY2dRVzFsY21sallTOU1iM05mUVc1blpXeGxjeUk3Q2draWIzSnBaMmx1WVd3dGNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhOUzB4TVMweU15QXhOam96TWpveU55QkZkR012UjAxVUlqc0tmUT09IjsiZW52aXJvbm1lbnQiID0gIlNhbmRib3giOyJwb2QiID0gIjEwMCI7InNpZ25pbmctc3RhdHVzIiA9ICIwIjt9"
    let sandboxReceiptSignature = "rggyUerdGnGZ4egPX+kuipPpNo6hd2zIoQvzEmloD2Nm4x+8ek1vTbnOyE5USq3j0vu5y8pWKKoykuGlVjU1Lg=="
    
    let badSandboxReceipt: String = "byJzaWduYXR1cmUiID0gIkFoaHEwbmFxaG01ci8wSUNuYk9hVThCeVBLNkRja2ZsanRCMDNnZUh4dk0ybEVjVkdqK2NVM1lnWGZ0RkZCZ2lFYkR1NGdoYXFVWFRqRzlpc25Zeit6VWFhTXRUZDJ6YnNLbFhIMitzYm1ZaC9tY2M2eWt3dVFkaFZsOWZKYkxNaFVXWHNTUlIxVlVjQlE4TkxjVGg5ZHNXOTVTREcxdG9DQk45cWM0L01CZlVBQUFEVnpDQ0ExTXdnZ0k3b0FNQ0FRSUNDQnVwNCtQQWhtL0xNQTBHQ1NxR1NJYjNEUUVCQlFVQU1IOHhDekFKQmdOVkJBWVRBbFZUTVJNd0VRWURWUVFLREFwQmNIQnNaU0JKYm1NdU1TWXdKQVlEVlFRTERCMUJjSEJzWlNCRFpYSjBhV1pwWTJGMGFXOXVJRUYxZEdodmNtbDBlVEV6TURFR0ExVUVBd3dxUVhCd2JHVWdhVlIxYm1WeklGTjBiM0psSUVObGNuUnBabWxqWVhScGIyNGdRWFYwYUc5eWFYUjVNQjRYRFRFME1EWXdOekF3TURJeU1Wb1hEVEUyTURVeE9ERTRNekV6TUZvd1pERWpNQ0VHQTFVRUF3d2FVSFZ5WTJoaGMyVlNaV05sYVhCMFEyVnlkR2xtYVdOaGRHVXhHekFaQmdOVkJBc01Fa0Z3Y0d4bElHbFVkVzVsY3lCVGRHOXlaVEVUTUJFR0ExVUVDZ3dLUVhCd2JHVWdTVzVqTGpFTE1Ba0dBMVVFQmhNQ1ZWTXdnWjh3RFFZSktvWklodmNOQVFFQkJRQURnWTBBTUlHSkFvR0JBTW1URXVMZ2ppbUx3Ukp4eTFvRWYwZXNVTkRWRUllNndEc25uYWwxNGhOQnQxdjE5NVg2bjkzWU83Z2kzb3JQU3V4OUQ1NTRTa01wK1NheWc4NGxUYzM2MlV0bVlMcFduYjM0bnF5R3g5S0JWVHk1T0dWNGxqRTFPd0Mrb1RuUk0rUUxSQ21lTnhNYlBaaFM0N1QrZVp0REVoVkI5dXNrMytKTTJDb2dmd283QWdNQkFBR2pjakJ3TUIwR0ExVWREZ1FXQkJTSmFFZU51cTlEZjZaZk42OEZlK0kydTIyc3NEQU1CZ05WSFJNQkFmOEVBakFBTUI4R0ExVWRJd1FZTUJhQUZEWWQ2T0tkZ3RJQkdMVXlhdzdYUXd1UldFTTZNQTRHQTFVZER3RUIvd1FFQXdJSGdEQVFCZ29xaGtpRzkyTmtCZ1VCQkFJRkFEQU5CZ2txaGtpRzl3MEJBUVVGQUFPQ0FRRUFlYUpWMlU1MXJ4ZmNxQUFlNUMyL2ZFVzhLVWw0aU80bE11dGE3TjZYelAxcFpJejFOa2tDdElJd2V5Tmo1VVJZSEsrSGpSS1NVOVJMZ3VObDBua2Z4cU9iaU1ja3dSdWRLU3E2OU5JbnJaeUNENjZSNEs3N25iOWxNVEFCU1NZbHNLdDhvTnRsaGdSLzFralNTUlFjSGt0c0RjU2lRR0tNZGtTbHA0QXlYZjd2bkhQQmU0eUN3WVYyUHBTTjA0a2JvaUozcEJseHNHd1YvWmxMMjZNMnVlWUhLWUN1WGhkcUZ3eFZnbTUyaDNvZUpPT3Qvdlk0RWNRcTdlcUhtNm0wM1o5YjdQUnpZTTJLR1hIRG1PTWs3dkRwZU1WbExEUFNHWXoxK1Uzc0R4SnplYlNwYmFKbVQ3aW16VUtmZ2dFWTd4eGY0Y3pmSDB5ajV3TnpTR1RPdlE9PSI7ICJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUxTFRFeExUSXpJREE0T2pNeU9qSTNJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdWeUlpQTlJQ0psTkRjME1qVmtaamRtWWpaaFlqaGpNMk0zWlRVM016QmpNMkUzWldJMVlqWTFOak00TWpOa0lqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2YmkxcFpDSWdQU0FpTVRBd01EQXdNREU0TVRRNU1qVTFOeUk3Q2draVluWnljeUlnUFNBaU15STdDZ2tpZEhKaGJuTmhZM1JwYjI0dGFXUWlJRDBnSWpFd01EQXdNREF4T0RFME9USTFOVGNpT3dvSkluRjFZVzUwYVhSNUlpQTlJQ0l4SWpzS0NTSnZjbWxuYVc1aGJDMXdkWEpqYUdGelpTMWtZWFJsTFcxeklpQTlJQ0l4TkRRNE1qazJNelEzTVRNNElqc0tDU0oxYm1seGRXVXRkbVZ1Wkc5eUxXbGtaVzUwYVdacFpYSWlJRDBnSWpWRE1qYzFRalZCTFRORk5qWXROREF5TmkwNU5USXpMVGcwTlVJeU1qVTNOVFZHUXlJN0Nna2ljSEp2WkhWamRDMXBaQ0lnUFNBaWNIVnlZMmhoYzJWeUxtTnZibk4xYldGaWJHVkdaV0YwZFhKbElqc0tDU0pwZEdWdExXbGtJaUE5SUNJeE1EWXhOVFUzTkRnMElqc0tDU0ppYVdRaUlEMGdJbU52YlM1bGN5NVFkWEpqYUdGelpYSWlPd29KSW5CMWNtTm9ZWE5sTFdSaGRHVXRiWE1pSUQwZ0lqRTBORGd5T1RZek5EY3hNemdpT3dvSkluQjFjbU5vWVhObExXUmhkR1VpSUQwZ0lqSXdNVFV0TVRFdE1qTWdNVFk2TXpJNk1qY2dSWFJqTDBkTlZDSTdDZ2tpY0hWeVkyaGhjMlV0WkdGMFpTMXdjM1FpSUQwZ0lqSXdNVFV0TVRFdE1qTWdNRGc2TXpJNk1qY2dRVzFsY21sallTOU1iM05mUVc1blpXeGxjeUk3Q2draWIzSnBaMmx1WVd3dGNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhOUzB4TVMweU15QXhOam96TWpveU55QkZkR012UjAxVUlqc0tmUT09IjsiZW52aXJvbm1lbnQiID0gIlNhbmRib3giOyJwb2QiID0gIjEwMCI7InNpZ25pbmctc3RhdHVzIiA9ICIwIjt9"
    let sandboxReceiptBadSignature = "eggyUerdGnGZ4egPX+kuipPpNo6hd2zIoQvzEmloD2Nm4x+8ek1vTbnOyE5USq3j0vu5y8pWKKoykuGlVjU1Lg=="
    
    override func spec() {
        
        let wrongInfo: AppInfo = AppInfo(appIdentifier: "50a96600-9434-11e9-9329-2f503c9b7e39", publicKey: self.wrongPubKey, useSandbox: true)
        let erroredInfo: AppInfo = AppInfo(appIdentifier: "50a96600-9434-11e9-9329-2f503c9b7e39", publicKey: self.errorPubKey, useSandbox: true)
        let sandboxInfo: AppInfo = AppInfo(appIdentifier: "50a96600-9434-11e9-9329-2f503c9b7e39", publicKey: self.pubKey, useSandbox: true)
        
        describe("Init checks") {
            it("can init") {
                expect {try Securio(with: sandboxInfo)}.toNot(throwError())
            }
            it("can init with wrong info") {
                expect {try Securio(with: wrongInfo)}.toNot(throwError())
            }
            it("cannot init with errored info") {
                expect {try Securio(with: erroredInfo)}.to(throwError())
            }
        }
        
        describe("Validation checks") {
            it("can validate sandbox receipt") {
                expect {
                    let client = try Securio(with: sandboxInfo)
                    waitUntil(timeout: 10) { done in
                        client.validate(receipt: self.sandboxReceipt) {  result in
                            let statusCheck: Bool
                            if case SecurioStatus.verified = result.status {
                                statusCheck = true
                            } else {
                                statusCheck = false
                            }
                            expect(statusCheck).to(beTrue())
                            done()
                        }
                    }
                    return true
                    }.toNot(throwError())
            }
            
            it("can invalidate sandbox receipt") {
                expect {
                    let client = try Securio(with: sandboxInfo)
                    waitUntil(timeout: 10) { done in
                        client.validate(receipt: self.badSandboxReceipt) {  result in
                            let statusCheck: Bool
                            if case SecurioStatus.verified = result.status {
                                statusCheck = true
                            } else {
                                statusCheck = false
                            }
                            expect(statusCheck).to(beFalse())
                            done()
                        }
                    }
                    return true
                    }.toNot(throwError())
            }
            
            it("can verify signature") {
                expect {
                    let client = try Securio(with: sandboxInfo)
                    expect(client.validate(data: self.sandboxReceipt, with: self.sandboxReceiptSignature)).to(beTrue())
                    expect(client.validate(data: self.sandboxReceipt, with: self.sandboxReceiptBadSignature)).to(beFalse())
                    return true
                    }.toNot(throwError())
            }
        }
    }
}
