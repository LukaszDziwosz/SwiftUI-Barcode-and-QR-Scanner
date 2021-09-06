//
//  ScannerView.swift
//  ScannerView
//
//  Created by Lukasz Dziwosz on 06/09/2021.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)//our own class inside struct :)
    }
    
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
    }
    
   // typealias UIViewControllerType = ScannerVC
    final class Coordinator: NSObject, ScannerVcDelegate {
       
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView){
            self.scannerView = scannerView
        }
        
        func didFindBarcode(barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didFindError(error: CameraError) {
            print(error.rawValue)
        }
        
        
    }
    
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(scannedCode: .constant("1234567890"))
    }
}
