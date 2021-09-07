//
//  ContentView.swift
//  SwiftUIBarcodeScanner
//
//  Created by Lukasz Dziwosz on 06/09/2021.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                ScannerView(scannedCode: $viewModel.scannedCode,
                            alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 40)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(viewModel.statusText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(nil)
                    //.scaledToFit()
                    .minimumScaleFactor(0.3)
                    .foregroundColor(viewModel.statusTextColor)
                    .textSelection(.enabled) //iOS 15 freature
                    .padding()
                
            }.navigationTitle("Barcode Scanner")
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: Text(alertItem.title),
                          message: Text(alertItem.message),
                          dismissButton: alertItem.dismiss)
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
