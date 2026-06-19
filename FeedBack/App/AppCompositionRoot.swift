//
//  AppCompositionRoot.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import SwiftUI

struct AppCompositionRoot: View {
    
    private let currentUser = AppUser(
            id: "u1",
            name: "Priyanka",
            email: "priyanka@test.com",
            role: .admin
        )
    
       private let repository = FirebaseFeedbackRepository()
    
    var body: some View {
        if currentUser.isAdmin {
            AdminFeedbackView(viewModel: AdminFeedbackViewModel(fetchAllFeedbackUseCase: FetchAllFeedbackUseCase(repository: repository)))
        } else {
            MyFeedbackView(
                viewModel: MyFeedbackViewModel(fetchMyFeedbackUseCases: FetchMyFeedbackUseCase(repository: repository), currentUser: currentUser)) {
                    AddFeedbackViewModel(submitFeedbackUseCase: SubmitFeedbackUseCase(repository: repository), currentUser: currentUser)
                }
        }
    }
}

#Preview {
    AppCompositionRoot()
}
