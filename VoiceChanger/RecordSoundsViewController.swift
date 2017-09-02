//
//  RecordSoundsViewController.swift
//  VoiceChanger
//
//  Created by Ahmed El-Kollaly on 9/2/17.
//  Copyright © 2017 Ahmed El-Kollaly. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    //Properties
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    enum PlayingState {case playing,notPlaying}
    var playingState :PlayingState = .notPlaying
    var audioRecorder :AVAudioRecorder!
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
        
        let sysPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingFileName = "recording.wave"
        let pathArray :[String] = [sysPath,recordingFileName]
        let fileURL = URL(fileURLWithPath: pathArray.joined(separator: "/"))
        
        //Get the shared audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        
        //Provides audio recording capability
        try! audioRecorder = AVAudioRecorder(url: fileURL, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
    }
    //Mark - Stop Recording
    @IBAction func stopRecording(_ sender: Any) {
        playingState = .notPlaying
        configureUI()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    //Mark -After Recording Has Finished
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            
        }else{
            print("Audio is finished unsccessfully")
        }
    }
}

