//
//  MetadataOutputViewController.swift
//  CodeScanner
//
//  Created by RoyChen on 2024/11/28.
//

import UIKit
import AVFoundation

class MetadataOutputViewController: UIViewController {
  
  var cameraSession = CameraSession()
  var preview: CameraPreview?

  override func viewDidLoad() {
    cameraSession.addMetadataOutputDelegate(self)
    preview = cameraSession.createPreviewView(frame: view.frame)
    view.addSubview(preview!)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    cameraSession.startRunning()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    cameraSession.stopRunning()
  }

}

extension MetadataOutputViewController: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    guard let metadataObject = metadataObjects.first else {
      return
    }
    guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
      print(metadataObject)
      return
    }
//    let capturePreview = preview?.previewLayer
//    guard let qrCodeObject = capturePreview!.transformedMetadataObject(for: readableObject) else { return }
//    print("qrCodeObject frame: \(qrCodeObject.bounds)")

    if let stringValue = readableObject.stringValue {
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      cameraSession.stopRunning()
      print("✅✅✅✅✅ Apple API检测到二维码: \(stringValue)")
    }
  }
}
