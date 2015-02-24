//
//  Spaceship.swift
//  MHackersGame
//
//  Created by Ameya Khare on 2/15/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//


import SpriteKit

class Spaceship: SKSpriteNode {
    
    var touchLocation: CGPoint = CGPoint()
    
    func moveVertically () {
        if (touchLocation.y > self.position.y+6) {
            self.position.y += CGFloat(6)
        } else if (touchLocation.y < self.position.y-6) {
            self.position.y += CGFloat(-6)
        }
    }
}
