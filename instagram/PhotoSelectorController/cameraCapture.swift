//
//  cameraCapture.swift
//  instagram
//
//  Created by youssef on 1/25/21.
//  Copyright © 2021 youssef. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CameraCapture : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCaptureSession()
    }
    
    
    func setUpCaptureSession() {
        let captionSessiov = AVCaptureSession()
        guard let captureDevise = AVCaptureDevice.default(for: .video) else { return  }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevise)
            if captionSessiov.canAddInput(input){
                captionSessiov.addInput(input)
            }
        } catch let error {
            print("error in capture photoes", error)
        }
        
        let output = AVCapturePhotoOutput()
        if captionSessiov.canAddOutput(output){
            captionSessiov.addOutput(output)
        }
        
         let preview = AVCaptureVideoPreviewLayer(session: captionSessiov)
        preview.frame = view.frame
        view.layer.addSublayer(preview)
        captionSessiov.startRunning()
        
    }
}
