//
//  ContentView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var documentsModel = DocumentsModel()
    @State var selectedIndex = 0
    @State var isFirstLaunch: Bool
    
    init() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "HasLaunchedBefore")
        _isFirstLaunch = State(initialValue: !hasLaunchedBefore)
        if isFirstLaunch {
            selectedIndex = 2
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                        ZStack {
                            switch selectedIndex {
                            case 0:
                                MainView(documentsModel: documentsModel, selectedIndex: $selectedIndex)
                            case 1:
                                ScanHistoryView(documentsModel: documentsModel)
                            case 2:
                                FirstLaunchView {
                                isFirstLaunch = false
                                UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
                                    selectedIndex = 0
                            }
                            default:
                                MainView(documentsModel: documentsModel, selectedIndex: $selectedIndex)
                            }
                        }
                    }
               
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Image(systemName: "document.viewfinder.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(5)
                            
                            Text("Scan")
                                .font(.system(size: 12))
                        }
                        .fontWeight(.bold)
                        .foregroundColor(selectedIndex == 0 ? Color.primary : Color.gray)
                        .onTapGesture {
                            selectedIndex = 0
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            Image(systemName: "text.document.fill")
                                .resizable()
                                .frame(width: 20, height: 25)
                                .padding(5)
                            
                            Text("Documents")
                                .font(.system(size: 12))
                        }
                        .fontWeight(.bold)
                        .foregroundColor(selectedIndex == 1 ? Color.primary  : Color.gray)
                        .onTapGesture {
                            selectedIndex = 1
                        }
                        Spacer()
                      
                     
                       
                    }
                
            }
        }
        .navigationBarHidden(true)

        
     .foregroundColor(Color.init(#colorLiteral(red: 0.1839159131, green: 0.1839159131, blue: 0.1839159131, alpha: 1)))
    }
}

#Preview {
    ContentView()
}
