//
//  SignInResponse.swift
//  CombineExample
//
//  Created by Matyatsko Mihail on 22.07.2022.
//

import Foundation

final class SignInResponse {
    
    var userLogin: String?
    var isSignedIn: Bool
    
    init(
        userLogin: String?,
        isSignedIn: Bool
    ) {
        self.userLogin = userLogin
        self.isSignedIn = isSignedIn
    }
    
}
