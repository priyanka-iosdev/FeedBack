//
//  AuthCoordinator.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import SwiftUI

@MainActor
@Observable
final class AuthCoordinator: Coordinator {
    enum Route: Hashable {
        case signup
    }
    
    var path = NavigationPath()
    private let authRepository: FirebaseAuthRepository
    
    init(authRepository: FirebaseAuthRepository) {
        self.authRepository = authRepository
    }
    
    func start() {
        path = NavigationPath()
    }
    
    func showSignup() {
        path.append(Route.signup)
    }
    
    func popToLogin() {
        path.removeLast()
    }
    
    //MARK: - View Factories
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            loginUseCase: LoginUseCase(authRepository: authRepository),
            signInWithGoogleUseCase: SignInWithGoogleUseCase(authRepository: authRepository),
            coordinator: self
        )
    }
 
    func makeSignupViewModel() -> SignupViewModel {
        SignupViewModel(
            signUpUseCase: SignUpUseCase(authRepository: authRepository),
            signInWithGoogleUseCase: SignInWithGoogleUseCase(authRepository: authRepository),
            coordinator: self
        )
    }
}
