//
//  GameViewController.swift
//  BrickBreaker
//
//  Created by SonVu on 9/11/16.
//  Copyright (c) 2016 SonVu. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1 cas view to SKView
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        //2 create game scene
        let gameScene = GameScene(size: skView.frame.size)
        
        //3 present
        skView.presentScene(gameScene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
