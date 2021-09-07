//
//  ScannerView.swift
//  ScannerView
//
//  Created by Lukasz Dziwosz on 06/09/2021.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
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
            switch error {
            case .previewUnable :
                scannerView.alertItem = AlertContext.previewUnable
            case .invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidMode:
                print("do more")
            case .sessionUnable:
                print("do more")
            case .metaDataOutout:
                print("do more")
            case .noObjects:
                print("do more")
            case .barcodeNotReadable:
                print("do more")
            case .invalidScannedValue:
                print("do more")
            }
        }
        
        
    }
    
}


