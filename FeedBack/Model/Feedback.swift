//
//  Feedback.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import Foundation

struct Feedback: Identifiable, Equatable {
    let id: String
    let userId: String
    let userName: String
    let mood: Mood
    let comment: String
    let createdAt: Date
 
    init(
        id: String = UUID().uuidString,
        userId: String,
        userName: String,
        mood: Mood,
        comment: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.userName = userName
        self.mood = mood
        self.comment = comment
        self.createdAt = createdAt
    }
}
