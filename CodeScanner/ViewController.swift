//
//  ViewController.swift
//  CodeScanner
//
//  Created by RoyChen on 2024/11/28.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func onAppleScanner(_ sender: Any) {
    let metadataoutputVC = MetadataOutputViewController()
    present(metadataoutputVC, animated: true)
  }
  
  @IBAction func onWechatQrcodeScanner(_ sender: Any) {
    let vc = WechatQrcodeViewController()
    present(vc, animated: true)
  }
  
  @IBAction func onHmsScanner(_ sender: Any) {
    let vc = HmsScannerViewController()
    present(vc, animated: true)
  }
}

