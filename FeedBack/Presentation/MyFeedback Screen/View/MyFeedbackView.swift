//
//  MyFeedbackView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import SwiftUI

struct MyFeedbackView: View {
    @State var viewModel: MyFeedbackViewModel
    let makeAddFeedbackViewModel: () -> AddFeedbackViewModel
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                DesignTokens.Color.pageBackground.ignoresSafeArea()
                
                VStack {
                    addButton
                        .padding(20)
                    
                    content
                    
                    Spacer()
                }
            }
            .onAppear { viewModel.load() }
            .sheet(isPresented: $viewModel.showAddSheet, onDismiss: { viewModel.load() }) {
                AddFeedbackView(viewModel: makeAddFeedbackViewModel())
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.errorMsg {
            VStack(spacing: 8) {
                Text("Something went wrong").font(DesignTokens.Font.headline)
                Text(error).font(DesignTokens.Font.body).foregroundColor(DesignTokens.Color.textSecondary)
                Button("Retry") {
                    viewModel.load()
                }
            }
        } else if viewModel.feedbackList.isEmpty {
            emptyState
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.feedbackList) { feedback in
                        FeedbackCardView(feedback: feedback, showAuthour: true)
                    }
                }
                .padding(16)
                .padding(.bottom, 70)
            }
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 10) {
            Text("🙂").font(.system(size: 48))
            Text("No feedback yet").font(DesignTokens.Font.headline)
            Text("Tap + to share your thoughts")
                .font(DesignTokens.Font.label)
                .foregroundColor(DesignTokens.Color.textSecondary)
        }
    }
    
    private var addButton: some View {
        HStack(alignment: .center) {
            Text("My Feedback")
                .font(DesignTokens.Font.title)
            Spacer()
            
            Button {
                viewModel.showAddSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 52, height: 52)
                    .background(DesignTokens.MoodColor.accent(for: .good))
                    .clipShape(Circle())
                    .shadow(radius: 4, y: 2)
            }
        }
    }
    
}

#Preview {
    MyFeedbackView(
           viewModel: MyFeedbackViewModel(
            fetchMyFeedbackUseCases: FetchMyFeedbackUseCase(repository: FirebaseFeedbackRepository()),
               currentUser: AppUser(id: "u1", name: "Priyanka", email: "p@x.com", role: .user)
           ),
           makeAddFeedbackViewModel: {
               AddFeedbackViewModel(
                   submitFeedbackUseCase: SubmitFeedbackUseCase(repository: FirebaseFeedbackRepository()),
                   currentUser: AppUser(id: "u1", name: "Priyanka", email: "p@x.com", role: .user)
               )
           }
       )
}
