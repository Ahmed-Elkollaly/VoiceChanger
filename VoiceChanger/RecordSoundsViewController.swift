//
//  RecordSoundsViewController.swift
//  VoiceChanger
//
//  Created by Ahmed El-Kollaly on 9/2/17.
//  Copyright © 2017 Ahmed El-Kollaly. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    enum PlayingState {case playing,notPlaying}
    var playingState :PlayingState = .notPlaying
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    //Mark -Configure UI
    func configureUI(){
        switch playingState {
        case .playing:
            recordButton.isEnabled = false
            stopButton.isEnabled = true
            recordLabel.text = "Recording ..."
        case .notPlaying:
            recordButton.isEnabled = true
            stopButton.isEnabled = false
            recordLabel.text = "Tap to record"
        }
    }
    //Mark -Start Recording
    @IBAction func startRecording(_ sender: Any) {
        playingState = .playing
        configureUI()
    }
    //Mark - Stop Recording
    @IBAction func stopRecording(_ sender: Any) {
        playingState = .notPlaying
        configureUI()
    }

}

