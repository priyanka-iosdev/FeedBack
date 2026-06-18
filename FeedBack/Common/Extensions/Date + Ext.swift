//
//  Date + Ext.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import Foundation

extension Date {
    var relativeDescription: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
