//
//  ContentView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    VStack {
                        Image(systemName: "document.viewfinder.fill")
                        Text("Skenovat")
                    }
                }
            ScanHistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "document.circle.fill")
                        Text("Doklady")
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
