//
//  NetworkWorker.swift
//  CombineExample
//
//  Created by Matyatsko Mihail on 22.07.2022.
//

import Foundation
import Combine

enum SignInErrors: String, Error {
    case wrongCredentials = "Wrong user credentials"
    case noConnectionToServer = "Server is unavaliable"
}

final class NetworkWorker {
    
    static let shared = NetworkWorker()
    
    func tryToSignIn(with login: String, password: String) -> Future<SignInResponse, SignInErrors> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let receivedLogin = "Login"
                let receivedPassword = "Password"
                if login == receivedLogin && password == receivedPassword {
                    promise(.success(.init(userLogin: receivedLogin, isSignedIn: true)))
                } else {
                    promise(.failure(.wrongCredentials))
                }
            }
        }
    }
    
}
