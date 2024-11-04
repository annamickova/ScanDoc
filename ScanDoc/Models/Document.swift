//
//  Document.swift
//  ScanDoc
//
//  Created by Anna Marie Mičková on 02.11.2024.
//

import SwiftUI

struct Document: Identifiable{
    let id = UUID()
    let image: UIImage
    let date: Date
    let description: String
}
