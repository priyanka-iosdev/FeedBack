//
//  SignupView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import SwiftUI

struct SignupView: View {
    @State var viewModel: SignupViewModel
    
    var body: some View {
        ZStack {
            DesignTokens.MoodColor.background(for: .neutral).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 28) {
                    Spacer(minLength: 20)
                    
                    VStack(spacing: 8) {
                        Text("🙂").font(.system(size: 56))
                        Text("Create account")
                            .font(DesignTokens.Font.title)
                            .foregroundColor(DesignTokens.MoodColor.accent(for: .neutral))
                        Text("Join and share your feedback")
                            .font(DesignTokens.Font.body)
                            .foregroundColor(DesignTokens.Color.textSecondary)
                    }
                    
                    VStack(spacing: 14) {
                        AuthTextField(placeholder: "Full Name",
                                      text: $viewModel.name,
                                      icon: "person")
                        
                        AuthTextField(placeholder: "Email",
                                      text: $viewModel.email,
                                      icon: "envelope")
                        
                        AuthTextField(placeholder: "Password (min 6 chars)",
                                      text: $viewModel.password,
                                      icon: "lock",
                                      isSecure: true)
                        
                        rolePicker
                        
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .font(DesignTokens.Font.caption)
                                .foregroundStyle(DesignTokens.Color.error)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)
                        }
                        
                        AuthPrimaryButton(title: "Sign Up",
                                          isLoading: viewModel.isLoading,
                                          mood: .neutral) {
                            viewModel.signUp()
                        }
                        
                        divider
                        
                        AuthGoogleButton(isLoading: viewModel.isLoading) {
                            viewModel.signUpWithGoogle()
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(DesignTokens.Font.body)
                            .foregroundColor(DesignTokens.Color.textSecondary)
                        Button("Log in") {
                            viewModel.goBack()
                        }
                        .font(DesignTokens.Font.label)
                        .foregroundColor(DesignTokens.MoodColor.accent(for: .neutral))
                    }
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private var rolePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("I am signing up as")
                .font(DesignTokens.Font.label)
                .foregroundColor(DesignTokens.Color.textSecondary)
            
            HStack(spacing: 12) {
                ForEach([UserRole.user, UserRole.admin], id: \.self) { role in
                    let isSelected = viewModel.selectedRole == role
                    Button {
                        viewModel.selectedRole = role
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(isSelected ? DesignTokens.MoodColor.accent(for: .neutral) : .secondary)
                            Text(role.rawValue.capitalized)
                                .font(DesignTokens.Font.label)
                                .foregroundColor(isSelected ? DesignTokens.MoodColor.accent(for: .neutral) : .primary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(isSelected ? DesignTokens.MoodColor.background(for: .neutral) : DesignTokens.Color.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius))
                        .overlay(
                            RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius)
                                .stroke(isSelected
                                        ? DesignTokens.MoodColor.accent(for: .neutral) : Color.clear, lineWidth: 1.5))
                    }
                }
            }
        }
        .padding(DesignTokens.Layout.cardPadding)
        .background(DesignTokens.Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius))
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
    SignupView(viewModel: SignupViewModel(signUpUseCase: SignUpUseCase(authRepository: firebaseAuthRepo), signInWithGoogleUseCase: SignInWithGoogleUseCase(authRepository: firebaseAuthRepo), coordinator: AuthCoordinator(authRepository: firebaseAuthRepo)))
}
