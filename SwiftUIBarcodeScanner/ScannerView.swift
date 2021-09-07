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
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)//our own class inside struct :)
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
        
        func didFindError(error: CameraError){
            switch error {
            case .previewUnable :
                scannerView.alertItem = AlertContext.previewUnable
            case .invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidMode:
                scannerView.alertItem = AlertContext.invalidMode
            case .sessionUnable:
                scannerView.alertItem = AlertContext.sessionUnable
            case .metaDataOutout:
                scannerView.alertItem = AlertContext.metaDataOutout
            case .noObjects:
                scannerView.alertItem = AlertContext.noObjects
            case .barcodeNotReadable:
                scannerView.alertItem = AlertContext.barcodeNotReadable
            case .invalidScannedValue:
                scannerView.alertItem = AlertContext.invalidScannedValue
            }
        }
        
        
    }
    
}


