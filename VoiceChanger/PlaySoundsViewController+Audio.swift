//
//  PlaySoundsViewController+Audio.swift
//  VoiceChanger
//
//  Created by Ahmed El-Kollaly on 9/2/17.
//  Copyright © 2017 Ahmed El-Kollaly. All rights reserved.
//

import Foundation
import AVFoundation

extension PlaySoundsViewController: AVAudioPlayerDelegate {
    
    func setupAudio(){
        do{
            audioFile = try AVAudioFile(forReading: audioFileURL as URL)
        }catch{
            NSLog("Audio File couldn't be read")
        }
    }
    func playAudio(rate:Float? = nil,pitch:Float? = nil,echo:Bool = false,reverb: Bool = false){
        
        
        audioEngine = AVAudioEngine()
        //supports scheduling the playback of segments of audio files opened via AVAudioFile
        audioNode = AVAudioPlayerNode()
        
        
        audioEngine.attach(audioNode)
        
        let changeRatePitchNode = AVAudioUnitTimePitch()
        
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        audioEngine.attach(changeRatePitchNode)
        
        //node for echo
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(.multiEcho1)
        audioEngine.attach(echoNode)
        
        //node for reverb
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.cathedral)
        reverbNode.wetDryMix = 50
        audioEngine.attach(reverbNode)
        
        if echo == true && reverb == true {
            connectNode(audioNode,changeRatePitchNode,echoNode,reverbNode,audioEngine.outputNode)
        }else if echo == true {
           self.connectNode(audioNode,changeRatePitchNode,echoNode,audioEngine.outputNode)
        }else if reverb == true {
            connectNode(audioNode,changeRatePitchNode,reverbNode,audioEngine.outputNode)
        }else {
            connectNode(audioNode,changeRatePitchNode,audioEngine.outputNode)
        }
        
        
        //Schedule to play and start engine
        audioNode.stop()
        audioNode.scheduleFile(audioFile, at: nil){
        
            var delayInSeconds :Double = 0
        
            if let lastRenderTime = self.audioNode.lastRenderTime, let playerTime = self.audioNode.playerTime(forNodeTime: lastRenderTime){
                if let rate = rate {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate) / Double(rate)
                } else {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate)
                }

            }
            
            // schedule a stop timer for when audio finishes playing
            self.stopTimer = Timer(timeInterval: delayInSeconds, target: self, selector: #selector(PlaySoundsViewController.stopAudio), userInfo: nil, repeats: false)
            RunLoop.main.add(self.stopTimer!, forMode: RunLoopMode.defaultRunLoopMode)
        }
                do {
                    try audioEngine.start()
                } catch {
                    NSLog("Audio Engine coundn't start")
                    return
                }
        
                // play the recording!
                audioNode.play()
        
       
    }
    
    func stopAudio(){
        if let audioNode = audioNode {
            audioNode.stop()
        }
        if let stopTimer = stopTimer {
            stopTimer.invalidate()
        }
        configureUI(.notPlaying)
        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }
    }
    func connectNode(_ nodes:AVAudioNode...){
        for x in 0 ..< nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
}
