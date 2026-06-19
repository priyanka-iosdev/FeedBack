//
//  AdminFeedbackView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import SwiftUI

struct AdminFeedbackView: View {
    @State var viewModel: AdminFeedbackViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                DesignTokens.Color.pageBackground.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    filterBar
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                    
                    content
                }
            }
            .navigationTitle("All feedback")
            .onAppear {
                viewModel.load()
            }
        }
    }
    
    private var filterBar: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("Rating")
                .font(DesignTokens.Font.headline)
            
            Spacer()
            
            filterChip(title: "All", mood: nil)
            ForEach(Mood.allCases, id: \.self) { mood in
                filterChip(title: mood.label.capitalized, mood: mood)
            }
        }
    }
    
    private func filterChip(title: String, mood: Mood?) -> some View {
        let isSelected = viewModel.selectedMoodFilter == mood
        return Button {
            viewModel.selectedMoodFilter = mood
        } label: {
            Text(title)
                .font(DesignTokens.Font.label)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? DesignTokens.MoodColor.accent(for: mood ?? .neutral) : DesignTokens.Color.cardBackground)
                .foregroundColor(isSelected ? .white : DesignTokens.Color.textPrimary)
                .clipShape(Capsule())
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView()
            Spacer()
        } else if let error = viewModel.errorMessage {
            Spacer()
            VStack(spacing: 8) {
                Text("Something went wrong").font(DesignTokens.Font.headline)
                Text(error).font(DesignTokens.Font.body).foregroundColor(DesignTokens.Color.textSecondary)
                Button("Retry") { viewModel.load() }
            }
            Spacer()
        } else if viewModel.feedbackList.isEmpty {
            Spacer()
            Text("No feedback for this filter")
                .font(DesignTokens.Font.body)
                .foregroundColor(DesignTokens.Color.textSecondary)
            Spacer()
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.feedbackList) { feedback in
                        FeedbackCardView(feedback: feedback, showAuthour: true)
                    }
                }
                .padding(16)
            }
        }
    }
}

#Preview {
    AdminFeedbackView(viewModel: AdminFeedbackViewModel(fetchAllFeedbackUseCase: FetchAllFeedbackUseCase(repository: FirebaseFeedbackRepository())))
}
