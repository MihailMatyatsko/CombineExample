//
//  SignInViewModel.swift
//  CombineExample
//
//  Created by Matyatsko Mihail on 22.07.2022.
//

import Foundation
import Combine

final class SignInViewModel: ISignInViewModel {
    
    var userLoginPubliser: Published<String?>.Publisher {
        return $userLogin
    }
    var isLoggedInPublisher: Published<Bool>.Publisher {
        return $isUserLoggedIn
    }
    var errorWhileLoggigInPublisher: Published<String?>.Publisher {
        return $errorWhileLoggigIn
    }
    
    var isCredentialsValidPublisher: Published<Bool>.Publisher {
        return $isCredentialsValid
    }
     
    @Published private var userLogin: String? = nil
    @Published private var isUserLoggedIn: Bool = false
    @Published private var errorWhileLoggigIn: String? = nil
    @Published private var validatorsArray: [Bool] = []
    @Published private var isCredentialsValid: Bool = false
    
    private var networkWorker: NetworkWorker = NetworkWorker.shared
    private var cancelable: Set<AnyCancellable> = []
    
    //MARK: - Public
    func tryLogIn(logIn: String, password: String) {
        networkWorker.tryToSignIn(
            with: logIn,
            password: password
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.errorWhileLoggigIn = nil
            case .failure(let error):
                self?.errorWhileLoggigIn = error.rawValue
                self?.userLogin = nil
                self?.isUserLoggedIn = false
            }
        } receiveValue: { [weak self] response in
            if response.isSignedIn, let login = response.userLogin {
                self?.userLogin = login
                self?.isUserLoggedIn = response.isSignedIn
            } else {
                self?.userLogin = nil
                self?.isUserLoggedIn = response.isSignedIn
            }
        }
        .store(in: &cancelable)
    }
    
    func validateCredentials(login: String?, password: String?) {
        if validateLogin(login: login) && validatePassword(password: password) {
            isCredentialsValid = true
        } else {
            isCredentialsValid = false
        }
    }
    
    //MARK: - Private
    private func validateLogin(login: String?) -> Bool {
        if let login = login, login.count > 4 {
            return true
        } else {
            return false
        }
    }
    
    private func validatePassword(password: String?) -> Bool {
        if let password = password, password.count > 5 {
            return true
        } else {
            return false
        }
    }
   
}
