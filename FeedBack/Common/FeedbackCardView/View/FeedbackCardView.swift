//
//  FeedbackCardView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import SwiftUI

struct FeedbackCardView: View {
    let feedback: Feedback
    var showAuthour: Bool = true
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(DesignTokens.MoodColor.background(for: feedback.mood))
                
                MoodFaceView(mood: feedback.mood,
                             size: 22,
                             color:DesignTokens.MoodColor.accent(for: feedback.mood)
                )
            }
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if showAuthour {
                        Text(feedback.userName)
                            .font(DesignTokens.Font.label)
                            .foregroundColor(DesignTokens.MoodColor.accent(for: feedback.mood))
                    }
                    
                    Spacer()
                    
                    Text(feedback.createdAt.relativeDescription)
                        .font(DesignTokens.Font.caption)
                        .foregroundStyle(DesignTokens.Color.textSecondary)
                }
                
                Text(feedback.comment)
                    .font(DesignTokens.Font.body)
                    .foregroundStyle(DesignTokens.Color.textPrimary)
            }
            
        }
        .padding(DesignTokens.Layout.cardPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignTokens.Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Layout.cardCornerRadius))
    }
}

#Preview {
    FeedbackCardView(feedback: Feedback(userId: "001", userName: "Priyank", mood: Mood.good, comment: "Great User Experience!"))
}
