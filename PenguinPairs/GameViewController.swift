//
//  GameViewController.swift
//  PenguinPairs
//
//  Created by Home on 8/14/16.
//  Copyright (c) 2016 Home. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = true
        skView.ignoresSiblingOrder = false
        skView.showsPhysics = false
        
        var viewSize = skView.bounds.size
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            viewSize.height *= 2
            viewSize.width *= 2
        }
        
        let scene = GameScene(size: viewSize)
        scene.scaleMode = .AspectFit
        skView.presentScene(scene)
        
    }
}
