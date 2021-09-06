//
//  ContentView.swift
//  SwiftUIBarcodeScanner
//
//  Created by Lukasz Dziwosz on 06/09/2021.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationView{
            VStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text("Not Yet Scanned")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
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
