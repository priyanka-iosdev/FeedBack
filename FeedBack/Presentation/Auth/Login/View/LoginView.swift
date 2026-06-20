//
//  LoginView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            DesignTokens.MoodColor.background(for: .good).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 28) {
                    Spacer(minLength: 40)
                    
                    //Header
                    VStack(spacing: 8) {
                        Text("👋").font(.system(size: 56))
                        Text("Welcome Back")
                            .font(DesignTokens.Font.title)
                            .foregroundStyle(DesignTokens.MoodColor.accent(for: .good))
                        Text("Sign in to continue")
                            .font(DesignTokens.Font.body)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                    }
                    
                    // FORM
                    VStack(spacing: 14) {
                        AuthTextField(placeholder: "Email",
                                      text: $viewModel.email,
                                      icon: "envelope")
                        
                        AuthTextField(placeholder: "Password",
                                      text: $viewModel.password,
                                      icon: "lock",
                                      isSecure: true)
                        
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .font(DesignTokens.Font.caption)
                                .foregroundColor(DesignTokens.Color.error)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)
                        }
                        
                        // loginButton
                        AuthPrimaryButton(title: "Login",
                                          isLoading: viewModel.isLoading,
                                          mood: .good) {
                            viewModel.login()
                        }
                        
                        divider
                        
                        AuthGoogleButton(isLoading: viewModel.isLoading) {
                            viewModel.signInWithGoogle()
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    //signUp Link
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .font(DesignTokens.Font.body)
                            .foregroundStyle(DesignTokens.Color.textSecondary)
                        Button("Sign up") {
                            viewModel.goToSignup()
                        }
                        .font(DesignTokens.Font.label)
                        .foregroundStyle(DesignTokens.MoodColor.accent(for: .good))
                    }
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private var divider: some View {
          HStack {
              Rectangle().frame(height: 1).foregroundColor(Color.gray.opacity(0.3))
              Text("or").font(DesignTokens.Font.caption).foregroundColor(.secondary)
              Rectangle().frame(height: 1).foregroundColor(Color.gray.opacity(0.3))
          }
      }
}

#Preview {
    let firebaseAuthRepo = FirebaseAuthRepository()
    LoginView(viewModel: LoginViewModel(loginUseCase: LoginUseCase(authRepository: firebaseAuthRepo), signInWithGoogleUseCase: SignInWithGoogleUseCase(authRepository: firebaseAuthRepo), coordinator: AuthCoordinator(authRepository: firebaseAuthRepo)))
}
