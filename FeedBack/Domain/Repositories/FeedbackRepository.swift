//
//   FeedbackRepository.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

protocol FeedbackRepository {
    func submit(_feedback: Feedback) async throws
    func fetchMyFeedback(userId: String) async throws -> [Feedback]
    func fetchAllFeedback() async throws -> [Feedback]
}
