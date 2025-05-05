//
//  MailComposeView.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 29.04.2025.
//


import SwiftUI
import MessageUI

struct MailComposeView: UIViewControllerRepresentable {
    let selectedDocument: Document
 
    init(selectedDocument: Document) {
        self.selectedDocument = selectedDocument
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(document: selectedDocument)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        if MFMailComposeViewController.canSendMail() {
            print("Can send email")
        }else{
            print("Can not send email")
        }
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = context.coordinator
                mailVC.setToRecipients(context.coordinator.generateRecipients())
                mailVC.setSubject(context.coordinator.generateEmailSubject())
                mailVC.setMessageBody(context.coordinator.generateEmailBody(), isHTML: false)


        return mailVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    
    
}
class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let document: Document

        init(document: Document) {
            self.document = document
        }

    /// Generating email structure  - body, subject, recipients.
        func generateEmailBody() -> String {
            print("Document: \(document.description)\n\n\(document.date)\n\(document.recognizedText ?? "No text recognized")")
         return "Document: \(document.description)\n\n\(document.date)\n\(document.recognizedText ?? "No text recognized"))"
        }

        func generateEmailSubject() -> String {
          return "ScanDoc"
        }

        func generateRecipients() -> [String] {
            ["mickova.annamarie@gmail.com"]
        }

    /// Getting image of document
    /// - Returns: Encoded data.
        func getFileData() -> Data? {
           return Data(base64Encoded: document.base64Image)
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            controller.dismiss(animated: true)
        }
    }
