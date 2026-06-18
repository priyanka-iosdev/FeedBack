//
//  AddFeedbackView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//


import SwiftUI

struct AddFeedbackView: View {
    @State private var slide: Double = 0.0
    let levels = ["Bad", "Normal", "Good"]
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Could You Share Your Feedback?")
                    .font(.title3).bold()
                Image(systemName: "xmark")
                
                Text("\(levels[Int(slide)])")
                
                Slider(value: $slide,
                       in: 0...2) {
                    Text("FeedBack")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("10")
                }
                .tint(.blue)
                
            }
            .padding()
        }
    }
}

#Preview {
    AddFeedbackView()
}
