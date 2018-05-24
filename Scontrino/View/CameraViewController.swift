//
//  CameraViewController.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 15/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        backButton.backgroundColor = .red
        backButton.addTarget(self, action: #selector(dismissCameraView), for: .touchUpInside)
        
        view.addSubview(backButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissCameraView() {
        self.dismiss(animated: true, completion: nil)
    }

}
