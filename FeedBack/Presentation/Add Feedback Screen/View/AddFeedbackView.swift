//
//  AddFeedbackView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//


import SwiftUI

struct AddFeedbackView: View {
    @State var viewModel: AddFeedbackViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                viewModel.background.ignoresSafeArea()
                
                VStack(spacing: 25) {
                    header
                    
                    Text("Could you share your thoughts on the app? I'd really value your perspective.")
                        .font(DesignTokens.Font.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(viewModel.accent)
                        .padding(.horizontal, 24)
                    
                    MoodFaceView(
                        mood: viewModel.mood,
                        size: faceSize(for: geo),
                        color: viewModel.accent
                    )
                    
                    Text(viewModel.mood.label)
                        .font(DesignTokens.Font.title)
                        .foregroundStyle(viewModel.accent)
                    
                    moodSlider
                        .padding(.horizontal, 8)
                    
                    
                    commentBox
                        .padding(.horizontal, 8)
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(DesignTokens.Font.caption)
                            .foregroundColor(DesignTokens.Color.error)
                    }
                    
                    Spacer()
                    
                }
                .padding()
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.mood)
            .alert("Thanks for your feedback!", isPresented: $viewModel.didSubmit) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
    
    private func faceSize(for geo: GeometryProxy) -> CGFloat {
        let proportional = geo.size.height * 0.13
        return min(max(proportional, 70), 130)
    }
    
    private var header: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(DesignTokens.Font.label)
                    .foregroundStyle(viewModel.accent)
                    .padding(10)
                    .background(Color.white.opacity(0.6))
                    .clipShape(Circle())
            }
            Spacer()
        }
    }
    
    private var moodSlider: some View {
        VStack(spacing: 8) {
            Slider(
                value: Binding(
                    get: { Double(viewModel.mood.rawValue) },
                    set: { viewModel.mood = Mood(rawValue: Int($0.rounded())) ?? .neutral }
                ),
                in: 0...Double(Mood.allCases.count - 1),
                step: 1
            )
            .tint(DesignTokens.MoodColor.sliderTrack(for: viewModel.mood))
        }
    }
    
    private var commentBox: some View {
        VStack(alignment: .trailing, spacing: 10) {
            TextField("Comment...", text: $viewModel.comment, axis: .vertical)
                .lineLimit(3...5)
                .font(DesignTokens.Font.body)
            
            Button(action: viewModel.submit) {
                HStack(spacing: 6) {
                    if viewModel.isSubmitting {
                        ProgressView().scaleEffect(0.7).tint(.white)
                    } else {
                        Text("Submit")
                        Image(systemName: "arrow.right")
                    }
                }
                .font(DesignTokens.Font.button)
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 9)
                .background(viewModel.accent)
                .clipShape(Capsule())
            }
            
        }
        .padding(14)
        .background(DesignTokens.Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}


#Preview {
    AddFeedbackView(
        viewModel: AddFeedbackViewModel(
            submitFeedbackUseCase: SubmitFeedbackUseCase(repository: FirebaseFeedbackRepository()),
            currentUser: AppUser(id: "u1", name: "Priyanka", email: "p@x.com", role: .user)
        )
    )
}
