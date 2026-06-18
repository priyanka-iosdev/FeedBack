//
//  DesignTokens.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import Foundation
import SwiftUI

enum DesignTokens {

    // MARK: - Typography (SF Pro / system font)

    enum Font {
        static let title = SwiftUI.Font.system(size: 22, weight: .bold)
        static let headline = SwiftUI.Font.system(size: 16, weight: .semibold)
        static let body = SwiftUI.Font.system(size: 14, weight: .regular)
        static let label = SwiftUI.Font.system(size: 13, weight: .semibold)
        static let caption = SwiftUI.Font.system(size: 11, weight: .regular)
        static let button = SwiftUI.Font.system(size: 14, weight: .semibold)
        static let faceEmoji: CGFloat = 90   // emoji sizes aren't Font weights, kept as raw size
    }

    // MARK: - Spacing & shape

    enum Layout {
        static let cardCornerRadius: CGFloat = 14
        static let sheetCornerRadius: CGFloat = 18
        static let cardPadding: CGFloat = 14
        static let screenPadding: CGFloat = 16
    }

    // MARK: - Color model

    /// Neutral palette — independent of mood, used for chrome, text, surfaces.
    enum Color {
        static let pageBackground = SwiftUI.Color(red: 0.94, green: 0.94, blue: 0.91)
        static let cardBackground = SwiftUI.Color.white
        static let textPrimary = SwiftUI.Color.primary
        static let textSecondary = SwiftUI.Color.secondary
        static let error = SwiftUI.Color.red
    }

    /// Mood-driven palette — this is what gives the MEOW screens their
    /// "color shifts with the slider" behavior.
    enum MoodColor {
        static func background(for mood: Mood) -> SwiftUI.Color {
            switch mood {
            case .bad: return SwiftUI.Color(red: 0.98, green: 0.93, blue: 0.85)     // amber 50
            case .neutral: return SwiftUI.Color(red: 0.97, green: 0.96, blue: 0.91) // warm neutral
            case .good: return SwiftUI.Color(red: 0.88, green: 0.96, blue: 0.93)    // mint 50
            }
        }

        static func accent(for mood: Mood) -> SwiftUI.Color {
            switch mood {
            case .bad: return SwiftUI.Color(red: 0.52, green: 0.31, blue: 0.04)     // amber 800
            case .neutral: return SwiftUI.Color(red: 0.53, green: 0.50, blue: 0.45) // warm gray 600
            case .good: return SwiftUI.Color(red: 0.03, green: 0.31, blue: 0.25)    // teal 800
            }
        }

        static func sliderTrack(for mood: Mood) -> SwiftUI.Color {
            switch mood {
            case .bad: return SwiftUI.Color(red: 0.94, green: 0.62, blue: 0.15)     // amber 500
            case .neutral: return SwiftUI.Color(red: 0.78, green: 0.76, blue: 0.66) // warm gray 400
            case .good: return SwiftUI.Color(red: 0.36, green: 0.79, blue: 0.65)    // mint 500
            }
        }
    }
}
