//
//  FirstViewController.swift
//  AudioMove
//
//  Created by duke on 2019/02/11.
//  Copyright © 2019 duke. All rights reserved.
//
import UIKit
import AudioKit
import AudioKitUI

class FirstViewController: UIViewController {

    // MARK: Properties
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet var press: UILongPressGestureRecognizer!
    
    let oscillator = AKOscillator()
    var envelope : AKAmplitudeEnvelope!
    var playgroundLoop : AKPlaygroundLoop!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initOSC() {
        oscillator.rampDuration = 0.1
        oscillator.frequency = 200
        oscillator.amplitude = 0.1
        
        let frequencies = (1...5).map{ $0 * 261.63} // 261.63 : the frequencies of middle C on a standard keyboard
        let oscillators = frequencies.map {
            createAndStartOscillator(frequency: $0)
        }
        let mixer = AKMixer()
        oscillators.forEach {
            mixer.connect(input: $0)
        }

        envelope = AKAmplitudeEnvelope(mixer, attackDuration: 0.1, decayDuration: 0.2, sustainLevel: 0.2, releaseDuration: 0.3)

        AudioKit.output = envelope
        try! AudioKit.start()
        
        oscillators.forEach{ $0.start() }
        
//        AKPlaygroundLoop(every: 0.5, handler: playLoop)
        playgroundLoop = AKPlaygroundLoop(every: 0.5) {
            if (self.envelope.isStarted) {
                self.envelope.stop()
            } else {
                self.envelope.start()
            }
        }
        
        
//        oscillator.start()
//        AKPlaygroundLoop(every: 0.5, handler: playLoop)
//        let filter = AKLowPassFilter(oscillator, cutoffFrequency: 22000.0, resonance: 0.2)
//
//
//        AudioKit.output = envelope
//        try! AudioKit.start()
//        oscillator.start()
////        envelope.start()
//        AKPlaygroundLoop(every: 0.5, handler: playLoop)
        
    }

    func stopAudioKit() {
        // Stop the engine.
        try! AudioKit.stop()
    }
    
    // MARK : Actions
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {        // Do any additional setup after loading the view.
        
        if (AudioKit.engine.isRunning) {
            stopAudioKit()
        } else {
            initOSC()
        }
    }
    
    @IBAction func pressAction(_ sender: UILongPressGestureRecognizer) {

        if (sender.state == UIGestureRecognizer.State.began) {
            NSLog("长按开始");
            
        } else if (sender.state == UIGestureRecognizer.State.ended) {
            NSLog("长按结束");
            
        } else if (sender.state == UIGestureRecognizer.State.changed) {
            
        } else {
            NSLog("长按中");
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
