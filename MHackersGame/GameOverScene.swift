//
//  File.swift
//  MHackersGame
//
//  Created by Ameya Khare on 2/15/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, score: Int) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.blackColor()
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Your score: \(score)    Tap to play again!"
        label.fontSize = 40
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let scene = GamePlayScene(size: size)
        scene.scaleMode = .AspectFill;
        self.view?.presentScene(scene)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
