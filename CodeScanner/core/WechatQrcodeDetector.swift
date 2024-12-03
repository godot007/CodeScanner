//
//  WechatQrcodeDetector.swift
//  CodeScanner
//
//  Created by RoyChen on 2024/12/2.
//
  

import opencv2

class WechatQRCodeDetector {
    var detector: WeChatQRCode

    init() {
        let bundle = Bundle.main
        let detectPrototxtPath = bundle.path(forResource: "detect", ofType: "prototxt")!
        let detectCaffeModelPath = bundle.path(forResource: "detect", ofType: "caffemodel")!
        let srPrototxtPath = bundle.path(forResource: "sr", ofType: "prototxt")!
        let srCaffeModelPath = bundle.path(forResource: "sr", ofType: "caffemodel")!

        self.detector = WeChatQRCode(detector_prototxt_path: detectPrototxtPath, detector_caffe_model_path: detectCaffeModelPath, super_resolution_prototxt_path: srPrototxtPath, super_resolution_caffe_model_path: srCaffeModelPath)
    }
    
    func detectAndDecode(from image: Mat, points: inout [Mat]) -> [String] {
        return detector.detectAndDecode(img: image)
    }
}
