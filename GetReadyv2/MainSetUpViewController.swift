//
//  MainSetUpViewController.swift
//  GetReady
//
//  Created by Eldon Chan on 9/1/16.
//  Copyright © 2016 Eldon. All rights reserved.
//

import UIKit
import HTPressableButton

class MainSetUpViewController: UIViewController {
    
    let readyButton = HTPressableButton(frame: CGRectMake(30, 150, 260, 50), buttonStyle: HTPressableButtonStyle.Rect)
    let logoImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpLayout() {
        
        //Logo constraint
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        logoImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        logoImageView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -50).active = true
        logoImageView.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.3).active = true
        logoImageView.widthAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.5).active = true
        
        //Continue button constraint
        view.addSubview(readyButton)
        readyButton.translatesAutoresizingMaskIntoConstraints = false
        readyButton.setTitle("Ready!", forState: .Normal)
        readyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        readyButton.buttonColor = UIColor.ht_bitterSweetColor()
        readyButton.shadowColor = UIColor.ht_bitterSweetDarkColor()
        readyButton.addTarget(self, action: #selector(startButtonTapped), forControlEvents: .TouchUpInside)
        readyButton.topAnchor.constraintEqualToAnchor(logoImageView.bottomAnchor, constant: 200).active = true
        readyButton.centerXAnchor.constraintEqualToAnchor(logoImageView.centerXAnchor).active = true

    }
    
    func startButtonTapped() {
        
        presentViewController(MainViewController(), animated: true, completion: nil)
        
    }

}
