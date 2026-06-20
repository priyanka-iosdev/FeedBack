//
//  CoordinatorView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import SwiftUI

struct CoordinatorView: View {
    @State private var coordinator = AppCoordinator()

    var body: some View {
        Group {
            if coordinator.isLoggedIn, let homeCoordinator = coordinator.homeCoordinator {
                HomeCoordinatorView(coordinator: homeCoordinator)
            } else if let authCoordinator = coordinator.authCoordinator {
                AuthCoordinatorView(coordinator: authCoordinator)
            } else {
                // resolving auth state
                ZStack {
                    DesignTokens.Color.pageBackground.ignoresSafeArea()
                    ProgressView()
                }
            }
        }
        .onAppear {
            coordinator.start()
        }
    }
}

// MARK: - Auth Flow

struct AuthCoordinatorView: View {
    let coordinator: AuthCoordinator

    var body: some View {
        NavigationStack(path: Binding(
            get: { coordinator.path },
            set: { coordinator.path = $0 }
        )) {
            LoginView(viewModel: coordinator.makeLoginViewModel())
                .navigationDestination(for: AuthCoordinator.Route.self) { route in
                    switch route {
                    case .signup:
                        SignupView(viewModel: coordinator.makeSignupViewModel())
                    }
                }
        }
    }
}

// MARK: - Home Flow

struct HomeCoordinatorView: View {
    let coordinator: HomeCoordinator

    var body: some View {
        NavigationStack(path: Binding(
            get: { coordinator.path },
            set: { coordinator.path = $0 }
        )) {
            if coordinator.currentUser.isAdmin {
                AdminFeedbackView(
                    viewModel: coordinator.makeAdminFeedbackViewModel(),
                    onLogout: { coordinator.logout() }
                )
            } else {
                MyFeedbackView(
                    viewModel: coordinator.makeMyFeedbackViewModel(),
                    makeAddFeedbackViewModel: {
                        coordinator.makeAddFeedbackViewModel()
                    },
                    onLogout: { coordinator.logout() }
                )
            }
        }
    }
}
