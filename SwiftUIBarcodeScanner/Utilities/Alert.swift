//
//  Alert.swift
//  Alert
//
//  Created by Lukasz Dziwosz on 07/09/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismiss: Alert.Button
}

struct AlertContext {
    static let previewUnable = AlertItem(title: "Unable To Start Preview", message: "Camera preview failed", dismiss: .default(Text("OK")))
    static let invalidMode = AlertItem(title: "Video capture not possible", message: "Device has no camera", dismiss: .default(Text("OK")))
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Camera not accesable", dismiss: .default(Text("OK")))
   static let sessionUnable = AlertItem(title: "Capturing session failed", message: "Failed to start capturing session", dismiss: .default(Text("OK")))
    static let metaDataOutout = AlertItem(title: "Barcode search failed", message: "Barcode search failed", dismiss: .default(Text("OK")))
    static let noObjects = AlertItem(title: "Barcode already displayed", message: "Please find new barcode", dismiss: .default(Text("OK")))
    static let barcodeNotReadable = AlertItem(title: "Barcode is not readable", message: "Barcode is not readable", dismiss: .default(Text("OK")))
    static let invalidScannedValue = AlertItem(title: "Barcode is not valid", message: "Barcode is not supported", dismiss: .default(Text("OK")))
    
}
