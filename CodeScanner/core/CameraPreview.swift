//
//  CameraPreview.swift
//  CodeScanner
//
//  Created by RoyChen on 2024/11/28.
//
  

import Foundation
import AVFoundation
import UIKit

final class CameraPreview: UIView {
  
  var previewLayer: AVCaptureVideoPreviewLayer {
    return layer as! AVCaptureVideoPreviewLayer
  }
  
  override public static var layerClass: AnyClass {
    return AVCaptureVideoPreviewLayer.self
  }
  
  init(frame: CGRect, session: AVCaptureSession) {
    super.init(frame: frame)
    previewLayer.session = session
    previewLayer.frame = bounds
    previewLayer.videoGravity = .resizeAspectFill
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
