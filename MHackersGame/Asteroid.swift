//
//  Asteroid.swift
//  MHackersGame
//
//  Created by Ameya Khare on 2/15/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import SpriteKit

class Asteroid: SKSpriteNode {
    
    var moveSpeed = 0
    
    func spawnToRandomLocation (width: CGFloat, height: CGFloat) {
        let randomY = random(min: self.size.height, max: height - self.size.height)
        
        self.position = CGPoint(x:width + random(min: 0, max: 800), y:randomY)
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func moveLeft (width: CGFloat, height: CGFloat) {
        self.position.x -= CGFloat(moveSpeed)
        
        if (self.position.x < CGFloat(0)) {
            spawnToRandomLocation(width, height: height)
        }
    }
}
