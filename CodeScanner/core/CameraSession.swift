//
//  CameraSession.swift
//  CodeScanner
//
//  Created by RoyChen on 2024/11/28.
//
  
import AVFoundation

class CameraSession {
  fileprivate var captureSession: AVCaptureSession!
  
  init() {
    captureSession = AVCaptureSession()
    configuration()
  }
  
  func configuration() {
    // 设置高分辨率以便识别出小区域的二维码
    if captureSession.canSetSessionPreset(AVCaptureSession.Preset.hd1920x1080) {
      captureSession.sessionPreset = .hd1920x1080
    }
    
    guard let device = AVCaptureDevice.default(for: .video) else { return }
    // 自动对焦使照片更清晰
    if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(.continuousAutoFocus) {
      try? device.lockForConfiguration()
      device.focusMode = .continuousAutoFocus
      device.unlockForConfiguration()
    }
    try? device.lockForConfiguration()
    // 自动曝光使光线条件更好
    device.exposureMode = .continuousAutoExposure
    device.unlockForConfiguration()

    guard let deviceInput = try? AVCaptureDeviceInput(device: device) else { return }
    
    if captureSession.canAddInput(deviceInput) {
      captureSession.addInput(deviceInput)
    }
    
  }
  
  func createPreviewView(frame: CGRect) -> CameraPreview {
    return CameraPreview(frame: frame, session: captureSession)
  }
  
  func startRunning() {
    if !captureSession.isRunning {
      DispatchQueue.global(qos: .background).async {
        self.captureSession.startRunning()
      }
    }
  }
  
  func stopRunning() {
    if captureSession.isRunning {
      captureSession.stopRunning()
    }
  }
}

extension CameraSession {
  
  func addMetadataOutputDelegate(_ objectsDelegate: AVCaptureMetadataOutputObjectsDelegate?, queue objectsCallbackQueue: dispatch_queue_t = DispatchQueue(label: "queue_video_meta_data")) {
    let metadataOutput = AVCaptureMetadataOutput()
    guard captureSession.canAddOutput(metadataOutput) else { return }
    
    captureSession.addOutput(metadataOutput)
    metadataOutput.setMetadataObjectsDelegate(objectsDelegate, queue: objectsCallbackQueue)
    metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
  }
  
  func addVideoDataOutputDelegate(_ sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate?, queue sampleBufferCallbackQueue: dispatch_queue_t = DispatchQueue(label: "queue_video_buffer_data")) {
    let videoOutput = AVCaptureVideoDataOutput()
    guard captureSession.canAddOutput(videoOutput) else { return }
        
    captureSession.addOutput(videoOutput)
    videoOutput.setSampleBufferDelegate(sampleBufferDelegate, queue: sampleBufferCallbackQueue)
  }
  
}
