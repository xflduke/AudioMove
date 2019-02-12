//
//  ViewController.swift
//  AudioMove
//
//  Created by duke on 2/9/31 H.
//  Copyright © 31 Heisei duke. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    var firstViewController : FirstViewController?
    
    let MAXTIME : Float = 1.0
    var currentTime : Float = 0.0
    var isProgessing : Bool = false
    var progessTimer : Timer!
    
    //MARK: Actions
    @IBOutlet weak var progessView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        progessView.progress = 0.0
        self.progessTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(RootViewController.updateProgess), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateProgess() {
        progessView.progress += 0.1
        progessView.setProgress(progessView.progress, animated: true)
        
        if (progessView.progress > MAXTIME) {
            progessTimer.invalidate()
            isProgessing = false
            
            // swich to other case
            if (firstViewController == nil) {
                firstViewController = (self.storyboard?.instantiateViewController(withIdentifier: "First") as! FirstViewController)
                
                firstViewController?.view.frame = view.frame
                switchToViewController(firstViewController)
            }
        }
        
    }
    
    func switchToViewController(_ toVC: UIViewController?) {
        if (toVC != nil) {
            addChild((toVC)!)
            view.addSubview((toVC?.view)!)
            toVC?.didMove(toParent: self)
        }
    }
    

//    @IBAction func startProgess(_ sender: Any) {
//
//        if (isProgessing) {
//            progessTimer.invalidate()
//            progessBtn.setTitle("Start", for: .normal)
//        }
//        else
//        {
//            progessBtn.setTitle("Stop", for: .normal)
//            progessView.progress = 0.0
//            self.progessTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(RootViewController.updateProgess), userInfo: nil, repeats: true)
//        }
//
//        isProgessing = !isProgessing
//
//    }
    
}


