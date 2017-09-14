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
    enum playMode : Int{case slow = 0,fast, chipmunk,robot,echo,reverb}
    enum PlayingState {case playing,notPlaying}
    var audioFileURL :URL!
    var audioFile :AVAudioFile!
    var audioNode :AVAudioPlayerNode!
    var audioEngine :AVAudioEngine!
    var stopTimer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureUI(.notPlaying)
    }
    func configureUI(_ playingState:PlayingState){
        if playingState == .notPlaying{
            slowButton.isEnabled = true
            fastButton.isEnabled = true
            chipmunkButton.isEnabled = true
            robotButton.isEnabled = true
            echoButton.isEnabled = true
            reverbButton.isEnabled = true
            
            stopButton.isEnabled = false
            
            
        }else if playingState == .playing{
            slowButton.isEnabled = false
            fastButton.isEnabled = false
            chipmunkButton.isEnabled = false
            robotButton.isEnabled = false
            echoButton.isEnabled = false
            reverbButton.isEnabled = false
            
            stopButton.isEnabled = true
        }
    }
    @IBAction func playSound(_ sender: UIButton) {
        configureUI(.playing)
        let tag = playMode(rawValue: sender.tag)!
        
        switch tag {
        case .slow:
            playAudio(rate: 0.5)
        case .fast:
            playAudio(rate: 1.5)
        case .echo:
            playAudio(echo: true)
        case .chipmunk:
            playAudio(pitch: 1000)
        case .robot:
            playAudio(pitch: -1000)
        case .reverb:
            playAudio(reverb: true)
      
        }
    
    }
    @IBAction func stopSound(_ sender: Any) {
        stopAudio()
    }
   
    
    
}
