//
//  HmsScannerViewController.swift
//  CodeScanner
//
//  Created by RoyChen on 2024/12/2.
//
  

import UIKit
import ScanKitFrameWork

class HmsScannerViewController: UIViewController {
  var hmsScannerVC: HmsCustomScanViewController?
  
  override func viewDidLoad() {
    hmsScannerVC = HmsCustomScanViewController()
    guard let hmsScannerVC else { return }
    hmsScannerVC.customizedScanDelegate = self
    hmsScannerVC.continuouslyScan = false
    hmsScannerVC.backButtonHidden = true
    view.addSubview(hmsScannerVC.view)
    addChild(hmsScannerVC)
    didMove(toParent: hmsScannerVC)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if hmsScannerVC == nil {
      hmsScannerVC = HmsCustomScanViewController()
      guard let hmsScannerVC else { return }
      hmsScannerVC.customizedScanDelegate = self
      hmsScannerVC.continuouslyScan = false
      hmsScannerVC.backButtonHidden = true
      view.addSubview(hmsScannerVC.view)
      addChild(hmsScannerVC)
      didMove(toParent: hmsScannerVC)
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    hmsScannerVC?.backAction()
  }

}

extension HmsScannerViewController: CustomizedScanDelegate {
  func customizedScanDelegate(forResult resultDic: [AnyHashable : Any]!) {
    if let dictionary = resultDic, let code = dictionary["text"] as? String {
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      print("✅✅✅✅✅ hms模型检测到二维码: \(code)")
      DispatchQueue.main.async {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        self.view.addSubview(vc.view)
        self.addChild(vc)
        self.didMove(toParent: vc)
        
        let resultLabel = UILabel()
        resultLabel.text = "✅✅✅✅✅ hms模型检测到二维码: \(code)"
        resultLabel.numberOfLines = 0
        vc.view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          resultLabel.leftAnchor.constraint(equalTo: vc.view.leftAnchor, constant: 16),
          resultLabel.rightAnchor.constraint(equalTo: vc.view.rightAnchor, constant: -16),
          resultLabel.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 60)
        ])
      }
    }
  }
}
