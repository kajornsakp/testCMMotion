//
//  ViewController.swift
//  testCMMotion
//
//  Created by Peerapathananont, Kajornsak (Agoda) on 6/10/2561 BE.
//  Copyright © 2561 Peerapathananont, Kajornsak (Agoda). All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var motionManager : CMMotionManager!
    
    var currentAcceration: CMAcceleration?
    
    let THRESHOLD = 200.0
    var count = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMMotionManager()
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue(), withHandler: self.handleMove)
        updateUI()
    }

    func handleMove(motion: CMDeviceMotion?, error: Error?) {
        guard let acceration = motion?.userAcceleration else {
            return
        }
        guard let previousAcceration = self.currentAcceration else {
            self.currentAcceration = acceration
            return
        }
        
        let deltaX = abs(acceration.x - previousAcceration.x) * 100
        let deltaY = abs(acceration.y - previousAcceration.y) * 100
        let deltaZ = abs(acceration.z - previousAcceration.z) * 100
        
        if(deltaX > THRESHOLD && deltaY > THRESHOLD){
            count += 1
        }
        else if(deltaX > THRESHOLD && deltaZ > THRESHOLD) {
            count += 1
        }
        else if(deltaY > THRESHOLD && deltaZ > THRESHOLD){
            count += 1
        }
        self.currentAcceration = acceration
        self.updateUI()
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.countLabel.text = "\(self.count)"
        }
    }
    @IBAction func resetCount(_ sender: Any) {
        self.count = 0
        updateUI()
    }
}

