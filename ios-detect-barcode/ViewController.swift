//
//  ViewController.swift
//  ios-detect-barcode
//
//  Created by Yoeun Samrith on 9/11/20.
//  Copyright © 2020 Yoeun Samrith. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "barcode"), let cgImage = image.cgImage {
            scanImage(cgImage: cgImage)
        }
    }
    
    private func scanImage(cgImage: CGImage) {
        let barcodeRequest = VNDetectBarcodesRequest(completionHandler: { request, error in
            let barCodeContent = self.reportResults(results: request.results)
            print("--------------- \(barCodeContent)")
        })
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        guard let _ = try? handler.perform([barcodeRequest]) else {
          return print("Could not perform barcode-request!")
        }
    }
    
    private func reportResults(results: [Any]?) -> String {
        var barCodeContent = ""
        if let results = results {
            results.forEach {
                if let barcode = $0 as? VNBarcodeObservation, let payload = barcode.payloadStringValue {
                    barCodeContent = payload
                    return
                }
            }
        }
        
        return barCodeContent
        
    }
    
}
