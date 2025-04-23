//
//  ScanDocApp.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI
import FirebaseCore

@main
struct ScanDocApp: App {
    init() {
           FirebaseApp.configure()
       }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
