//
//  PlaySoundsViewController.swift
//  VoiceChanger
//
//  Created by Ahmed El-Kollaly on 9/2/17.
//  Copyright © 2017 Ahmed El-Kollaly. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    
    @IBOutlet weak var robotButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    var audioFileURL :URL!
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func playSound(_ sender: Any) {
    }
    @IBAction func stopSound(_ sender: Any) {
    }
    
    
}
