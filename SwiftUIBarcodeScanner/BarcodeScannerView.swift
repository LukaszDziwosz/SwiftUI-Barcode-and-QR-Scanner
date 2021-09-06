//
//  ContentView.swift
//  SwiftUIBarcodeScanner
//
//  Created by Lukasz Dziwosz on 06/09/2021.
//

import SwiftUI

struct BarcodeScannerView: View {
    @State private var scannedCode: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                ScannerView(scannedCode: $scannedCode)
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
