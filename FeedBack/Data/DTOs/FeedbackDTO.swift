//
//  FeedbackDTO.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import FirebaseFirestore

struct FeedbackDTO: Codable {
    @DocumentID var id: String?
    var userId: String
    var userName: String
    var mood: Int
    var comment: String
    var createdAt: TimeInterval
    
    init(feedback: Feedback) {
        self.id = feedback.id
        self.userId = feedback.userId
        self.userName = feedback.userName
        self.mood = feedback.mood.rawValue
        self.comment = feedback.comment
        self.createdAt = feedback.createdAt.timeIntervalSince1970
    }
    
    func toDomain() -> Feedback {
        Feedback(id: id ?? UUID().uuidString,
                 userId: userId,
                 userName: userName,
                 mood: Mood(rawValue: mood) ?? .neutral,
                 comment: comment,
                 createdAt: Date(timeIntervalSince1970: createdAt))
    }
}
