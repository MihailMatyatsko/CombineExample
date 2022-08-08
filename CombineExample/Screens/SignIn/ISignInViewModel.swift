//
//  ISignInViewModel.swift
//  CombineExample
//
//  Created by Matyatsko Mihail on 22.07.2022.
//

import Foundation
import Combine

protocol ISignInViewModel {
    var userLoginPubliser: Published<String?>.Publisher { get }
    var isLoggedInPublisher: Published<Bool>.Publisher { get }
    var isCredentialsValidPublisher: Published<Bool>.Publisher { get }
    var errorWhileLoggigInPublisher: Published<String?>.Publisher { get }
    
    func validateCredentials(login: String?, password: String?)
    func tryLogIn(logIn: String, password: String)
}
