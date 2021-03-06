//
//  GameScene.swift
//  MHackersGame
//
//  Created by Ameya Khare on 2/15/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = SKColor.blackColor()
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Avoid the asteroids for as long as you can!"
        label.fontSize = 40
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        let label2 = SKLabelNode(fontNamed: "Chalkduster")
        label2.text = "Tap anywhere to continue."
        label2.fontSize = 40
        label2.fontColor = SKColor.whiteColor()
        label2.position = CGPoint(x: size.width/2, y: size.height*0.4)
        addChild(label2)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let scene = GamePlayScene(size: size)
        scene.scaleMode = .AspectFill;
        self.view?.presentScene(scene)
    }
}
