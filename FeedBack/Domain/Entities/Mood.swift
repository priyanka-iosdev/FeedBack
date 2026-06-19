//
//  Mood.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import Foundation

enum Mood: Int, CaseIterable, Codable {
    case bad = 0
    case neutral = 1
    case good = 2
    
    var label: String {
        switch self {
        case .bad:
            return "BAD"
        case .neutral:
            return "OK"
        case .good:
            return "GOOD"
        }
    }
    
    var emoji: String {
        switch self {
        case .bad: return "😟"
        case .neutral: return "😐"
        case .good: return "🙂"
        }
    }
}
