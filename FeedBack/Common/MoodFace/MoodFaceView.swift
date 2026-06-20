//
//  MoodFaceView.swift
//  FeedBack
//
//  Created by Priyank Yadav on 20/06/26.
//

import SwiftUI

struct MoodFaceView: View {
    let mood: Mood
    var size: CGFloat = 100
    var color: Color = .primary
    
    var body: some View {
        ZStack {
            EyebrowsShape(mood: mood)
                .stroke(color, style: StrokeStyle(lineWidth: size * 0.06, lineCap: .round))
            
            EyesShape(mood: mood)
                .fill(color)
            
            MouthShape(mood: mood)
                .stroke(color, style: StrokeStyle(lineWidth: size * 0.06, lineCap: .round))
        }
        .frame(width: size, height: size * 1.1)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: mood)
        .accessibilityLabel(mood.label)
    }
    
    private struct EyebrowsShape: Shape {
        var mood: Mood
        
        var animatableData: Double {
            get { Double(mood.rawValue) }
            set { mood = Mood(rawValue: Int(newValue.rounded())) ?? .neutral }
        }
        
        func path(in rect: CGRect) -> Path {
            let w = rect.width
            let h = rect.height
            var path = Path()
            
            // brow tilt: 1 = angled (bad), 0 = flat (normal/good)
            let tilt = mood == .bad ? 1.0 : 0.0
            let browY = h * 0.30
            let tiltOffset = h * 0.08 * tilt
            
            // left brow
            path.move(to: CGPoint(x: w * 0.16, y: browY - tiltOffset))
            path.addLine(to: CGPoint(x: w * 0.40, y: browY + tiltOffset))
            
            // right brow
            path.move(to: CGPoint(x: w * 0.84, y: browY - tiltOffset))
            path.addLine(to: CGPoint(x: w * 0.60, y: browY + tiltOffset))
            
            return path
        }
    }
    
    private struct EyesShape: Shape {
        var mood: Mood
        
        var animatableData: Double {
            get { Double(mood.rawValue) }
            set { mood = Mood(rawValue: Int(newValue.rounded())) ?? .neutral }
        }
        
        func path(in rect: CGRect) -> Path {
            let w = rect.width
            let h = rect.height
            let eyeRadius = w * 0.07
            let eyeY = h * 0.46
            
            var path = Path()
            path.addEllipse(in: CGRect(
                x: w * 0.32 - eyeRadius, y: eyeY - eyeRadius,
                width: eyeRadius * 2, height: eyeRadius * 2
            ))
            path.addEllipse(in: CGRect(
                x: w * 0.68 - eyeRadius, y: eyeY - eyeRadius,
                width: eyeRadius * 2, height: eyeRadius * 2
            ))
            return path
        }
    }
    
    private struct MouthShape: Shape {
        var mood: Mood
        
        var animatableData: Double {
            get { Double(mood.rawValue) }
            set { mood = Mood(rawValue: Int(newValue.rounded())) ?? .neutral }
        }
        
        func path(in rect: CGRect) -> Path {
            let w = rect.width
            let h = rect.height
            var path = Path()
            
            switch mood {
            case .bad:
                // frown: starts low at corners, dips up in the middle (inverted U)
                let y = h * 0.72
                path.move(to: CGPoint(x: w * 0.40, y: y + h * 0.08))
                path.addQuadCurve(
                    to: CGPoint(x: w * 0.60, y: y + h * 0.08),
                    control: CGPoint(x: w * 0.50, y: y - h * 0.05)
                )
                
            case .neutral:
                // flat line
                let y = h * 0.74
                path.move(to: CGPoint(x: w * 0.42, y: y))
                path.addLine(to: CGPoint(x: w * 0.58, y: y))
                
            case .good:
                // smile: dips down in the middle (U shape)
                let y = h * 0.70
                path.move(to: CGPoint(x: w * 0.38, y: y))
                path.addQuadCurve(
                    to: CGPoint(x: w * 0.62, y: y),
                    control: CGPoint(x: w * 0.50, y: y + h * 0.14)
                )
            }
            
            return path
        }
    }
}

#Preview {
    HStack(spacing: 32) {
        ForEach(Mood.allCases, id: \.self) { mood in
            VStack {
                MoodFaceView(mood: mood, size: 80, color: DesignTokens.MoodColor.accent(for: mood))
                Text(mood.label).font(.caption)
            }
        }
    }
    .padding()
}
