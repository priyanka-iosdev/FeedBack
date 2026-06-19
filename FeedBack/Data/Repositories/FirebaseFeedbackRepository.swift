//
//  FirebaseFeedbackRepository.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import FirebaseFirestore

final class FirebaseFeedbackRepository: FeedbackRepository {
    private let db = Firestore.firestore()
    private let collectionName = "feedback"
    
    func submit(_ feedback: Feedback) async throws {
        let dto = FeedbackDTO(feedback: feedback)
        let docId = dto.id ?? UUID().uuidString
        let data: [String: Any] = [
            "userId": dto.userId,
            "userName": dto.userName,
            "mood": dto.mood,
            "comment": dto.comment,
            "createdAt": dto.createdAt
        ]
        
        try await db.collection(collectionName)
            .document(docId)
            .setData(data)
    }
    
    func fetchMyFeedback(userId: String) async throws -> [Feedback] {
        let snapshot = try await db.collection(collectionName)
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
        
        return snapshot.documents.compactMap {
            try? $0.data(as: FeedbackDTO.self).toDomain()
        }
    }
    
    func fetchAllFeedback() async throws -> [Feedback] {
        let snapshot = try await db.collection(collectionName).getDocuments()
        
        return snapshot.documents.compactMap {
            try? $0.data(as: FeedbackDTO.self).toDomain()
        }
    }
}

