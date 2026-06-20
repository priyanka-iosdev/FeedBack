//
//  AuthTextField.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    @Binding var text: String
    var icon: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(DesignTokens.Font.body)
                .foregroundStyle(.secondary)
                .frame(width: 20)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(DesignTokens.Font.body)
            } else {
                TextField(placeholder, text: $text)
                    .font(DesignTokens.Font.body)
                    .keyboardType(placeholder.lowercased().contains("email") ? .emailAddress : .default)
                    .autocapitalization(.none)
            }
        }
        .padding(14)
        .background(DesignTokens.Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius))
    }
}

// MARK: - AuthPrimaryButton

struct AuthPrimaryButton: View {
    let title: String
    var isLoading: Bool
    var mood: Mood
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView().scaleEffect(0.8).tint(.white)
                } else {
                    Text(title)
                        .font(DesignTokens.Font.button)
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(DesignTokens.MoodColor.accent(for: mood))
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius))
        }
        .disabled(isLoading)
    }
}

// MARK: - AuthGoogleButton

struct AuthGoogleButton: View {
    var isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "globe")
                    .font(DesignTokens.Font.body)
                Text("Continue with Google")
                    .font(DesignTokens.Font.button)
            }
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(DesignTokens.Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius))
            .overlay (
                RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .disabled(isLoading)
    }
}
