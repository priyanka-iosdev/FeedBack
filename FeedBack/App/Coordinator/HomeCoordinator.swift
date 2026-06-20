//
//  HomeCoordinator.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class HomeCoordinator: Coordinator {
    enum Route: Hashable {
        case addFeedback
    }

    var path = NavigationPath()
    let currentUser: AppUser
    private let repository: FirebaseFeedbackRepository
    private weak var appCoordinator: AppCoordinator?

    init(currentUser: AppUser, repository: FirebaseFeedbackRepository, appCoordinator: AppCoordinator) {
        self.currentUser = currentUser
        self.repository = repository
        self.appCoordinator = appCoordinator
    }

    func start() {
        path = NavigationPath()
    }

    func showAddFeedback() {
        path.append(Route.addFeedback)
    }

    func pop() {
        path.removeLast()
    }
    
    func logout() {
        appCoordinator?.logout()
    }

    // MARK: - View factories

    func makeMyFeedbackViewModel() -> MyFeedbackViewModel {
        MyFeedbackViewModel(
            fetchMyFeedbackUseCases: FetchMyFeedbackUseCase(repository: repository),
            currentUser: currentUser
        )
    }

    func makeAdminFeedbackViewModel() -> AdminFeedbackViewModel {
        AdminFeedbackViewModel(
            fetchAllFeedbackUseCase: FetchAllFeedbackUseCase(repository: repository)
        )
    }

    func makeAddFeedbackViewModel() -> AddFeedbackViewModel {
        AddFeedbackViewModel(
            submitFeedbackUseCase: SubmitFeedbackUseCase(repository: repository),
            currentUser: currentUser
        )
    }
}
