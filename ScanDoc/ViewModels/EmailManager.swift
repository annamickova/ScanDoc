//
//  EmailManager.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 29.04.2025.
//


import SwiftUI
import MessageUI

class EmailManager: NSObject, ObservableObject, MFMailComposeViewControllerDelegate {
    @Published var showMailCompose = false
    @Published var document: Document
    @Published var emailAddress: String?
    @Published var showAlert: Bool
    
    init(document: Document) {
        self.document = document
        self.showAlert = false
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            showMailCompose = true
        } else {
            print("Cannot send email")
        }
    }
    /// Generating email structure  - body, subject, recipients.

    func generateEmailBody() -> String {
        "Document: \(document.description)\n\n\(document.date)\n\(String(describing: document.recognizedText))"
    }
    
    func generateEmailSubject() -> String {
        "ScanDoc"
    }
    
    func generateRecipients() -> [String] {
        return emailAddress != nil && !emailAddress!.isEmpty ? [emailAddress!] : []
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .sent {
            showAlert = true
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    /// Getting image of document
    /// - Returns: Encoded data.
    func getFileData() -> Data? {
        return Data(base64Encoded: document.base64Image)
    }
    
    
}
