//
//  ScannerVC.swift
//  ScannerVC
//
//  Created by Lukasz Dziwosz on 06/09/2021.
//

import UIKit
import AVFoundation
import SwiftUI

enum CameraError {
    case invalidDeviceInput
    case invalidMode
    case sessionUnable
    case metaDataOutout
    case noObjects
    case barcodeNotReadable
    case invalidScannedValue
    case previewUnable
}

protocol ScannerVcDelegate: AnyObject {
    func didFindBarcode(barcode: String)
    func didFindError(error: CameraError)
}

final class ScannerVC: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVcDelegate?
    
    init(scannerDelegate: ScannerVcDelegate) {
        super.init(nibName: nil, bundle: nil)
         
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession (){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didFindError(error: .invalidMode)
            return
        }
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch{
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }else{
            scannerDelegate?.didFindError(error: .sessionUnable)
            return
        }
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput){
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13, .code39, .code39Mod43, .code93, .code128, .interleaved2of5, .itf14, .upce, .qr, .aztec, .dataMatrix, .pdf417]
        }else{
            scannerDelegate?.didFindError(error: .metaDataOutout)
            return
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        if let previewLayer = previewLayer {
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        }
        captureSession.startRunning()
        
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didFindError(error: .noObjects)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didFindError(error: .barcodeNotReadable)
            return
        }
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didFindError(error: .invalidScannedValue)
            return
        }
      //  captureSession.stopRunning() //returning only one barcode
        scannerDelegate?.didFindBarcode(barcode: barcode)
    }
}
