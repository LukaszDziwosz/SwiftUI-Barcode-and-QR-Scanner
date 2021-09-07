//
//  ContentView.swift
//  SwiftUIBarcodeScanner
//
//  Created by Lukasz Dziwosz on 06/09/2021.
//

import SwiftUI

struct AlertItem {
    let title: String
    let message: String
    let dismiss: Alert.Button
    }
struct AlertContext {
    static let previewUnable = AlertItem(title: "Unable To Start Preview", message: "Camera preview failed", dismiss: .default(Text("OK")))
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Camera not accesable", dismiss: .default(Text("OK")))
}
struct BarcodeScannerView: View {
    
    @State private var scannedCode = ""
    @State private var alertItem: AlertItem?
    
    var body: some View {
        NavigationView{
            VStack{
                ScannerView(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(scannedCode.isEmpty ? .red : .green)
                    .padding()
                
            }.navigationTitle("Barcode Scanner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
