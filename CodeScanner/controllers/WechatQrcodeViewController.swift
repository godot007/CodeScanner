//
//  WechatQrcodeViewController.swift
//  CodeScanner
//
//  Created by RoyChen on 2024/11/29.
//
  

import UIKit
import AVFoundation
import opencv2

class WechatQrcodeViewController: UIViewController {
  var cameraSession = CameraSession()
  var preview: CameraPreview?
  
  override func viewDidLoad() {
    cameraSession.addVideoDataOutputDelegate(self)
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

extension WechatQrcodeViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    // cgImage
    let ciImage = CIImage(cvPixelBuffer: imageBuffer)
    let context = CIContext(options: nil)
    
    guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
    
    // cvImage
    let cvImage = Mat(cgImage: cgImage)
    
    // WechatQRCodeDetector
    var points: [Mat] = []
    let qrcodes = WechatQRCodeDetector().detectAndDecode(from: cvImage, points: &points)
    if qrcodes.count > 0 {
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      cameraSession.stopRunning()
      print("✅✅✅✅✅ 微信模型检测到二维码:")
      for (index, value) in qrcodes.enumerated() {
        print("\(index+1): \(value)")
      }
    }
  }
}
