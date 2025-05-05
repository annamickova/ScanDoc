//
//  FirstLaunchView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 26.04.2025.
//
import SwiftUI

struct FirstLaunchView: View {
    @State private var currentIndex = 0
    private let caption = ["What is ScanDoc", "Main functions", "Caption3"]
        private let text = ["text1", "- scan documents\n- save documents\n-share documents", "text3"]
        
        var onDismiss: () -> Void

        var body: some View {
            VStack {
                Text(caption[currentIndex])
                    .font(.system(size: 26))
                    .fontWeight(.heavy)
                    .padding(.vertical, 80)
                
                Text(text[currentIndex])
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .lineSpacing(16)
                    .multilineTextAlignment(.center)
                    .padding()
                    .animation(.easeInOut, value: currentIndex)

                Spacer()
                Button(action: {
                    if currentIndex < text.count - 1 {
                        currentIndex += 1
                    } else {
                        onDismiss()
                    }
                }) {
                    Text(currentIndex < text.count - 1 ? "Next" : "Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .padding(.horizontal, 80)
                        .background(Color.init(#colorLiteral(red: 0.1839159131, green: 0.1839159131, blue: 0.1839159131, alpha: 1)))
                        .cornerRadius(30)
                }
                .padding(.bottom, 200)
            }
            .foregroundColor(.primary)
            .background(Color(.systemBackground))
            .padding()
        }
}
 
#Preview {
    FirstLaunchView(onDismiss: {})
}
