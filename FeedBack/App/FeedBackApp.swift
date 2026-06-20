//
//  FeedBackApp.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import SwiftUI
import Firebase

@main
struct FeedBackApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //            AppCompositionRoot()
            CoordinatorView()
        }
    }
}
