//
//  ContentView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var documentsModel = DocumentsModel()
    var body: some View {
        TabView {
            MainView(documentsModel: documentsModel)
                .tabItem {
                    VStack {
                        Image(systemName: "document.viewfinder.fill")
                        Text("Skenovat")
                    }
                }
            ScanHistoryView(documentsModel: documentsModel)
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
