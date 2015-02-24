//
//  GamePlayScene.swift
//  MHackersGame
//
//  Created by Ameya Khare on 2/15/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import SpriteKit

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Asteroid  : UInt32 = 0b1
        static let Spaceship : UInt32 = 0b10
    }
    
    let player = Spaceship(imageNamed: "spaceship_animated.gif")
    let scoreDisp = SKLabelNode(fontNamed: "Chalkduster")
    let helpText = SKLabelNode(fontNamed: "Chalkduster")
    var asteroids: [Asteroid] = []
    var PLAYER_ACTIVE = false;
    var tickPoint = 1
    var score = 0
    
    override func didMoveToView(view: SKView) {
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x:(size.width * 0.1), y:(size.height * 0.5))
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.dynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.Spaceship
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
        player.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.addChild(player)
        
        helpText.text = "Tap to start!"
        helpText.fontSize = 40
        helpText.fontColor = SKColor.whiteColor()
        helpText.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(helpText)
        
        asteroids = createAsteroidArray(6, large: 3)
        for asteroid in asteroids {
            asteroid.spawnToRandomLocation(size.width, height: size.height)
            asteroid.physicsBody = SKPhysicsBody(rectangleOfSize: asteroid.size)
            asteroid.physicsBody?.dynamic = true
            asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Asteroid
            asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Spaceship
            asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None
            self.addChild(asteroid)
        }
        
        self.backgroundColor = SKColor.blackColor()
        
        scoreDisp.text = "Your score is: \(score)"
        scoreDisp.fontSize = 20
        scoreDisp.fontColor = SKColor.whiteColor()
        scoreDisp.position = CGPoint(x:(size.width * 0.8), y:(size.height * 0.15))
        self.addChild(scoreDisp)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (!PLAYER_ACTIVE) {
            PLAYER_ACTIVE = true
            helpText.removeFromParent()
        }
        
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        
        player.touchLocation = touchLocation
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        
        player.touchLocation = touchLocation
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        player.touchLocation = player.position
    }
    
    override func update(currentTime: CFTimeInterval) {
        if (!PLAYER_ACTIVE) {return}
        
        tickPoint++
        score += 10
        scoreDisp.text = "Your score is: \(score)"
        
        if(tickPoint%100 == 0) {
            for asteroid in asteroids {
                if (asteroid.random() < 0.5) {
                    asteroid.moveSpeed++
                }
            }
            
            tickPoint = 1
        }
        
        player.moveVertically()
        
        for asteroid in asteroids {
            asteroid.moveLeft(size.width,height: size.height)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let scene = GameOverScene(size: size, score: score)
        scene.scaleMode = .AspectFill;
        self.view?.presentScene(scene)
    }
    
    func createAsteroidArray (small: Int, large: Int) -> [Asteroid] {
        var asteroids: [Asteroid] = []
        
        for index in  0..<small {
            asteroids.append(Asteroid(imageNamed: "asteroid_small.png"))
            asteroids[index].moveSpeed = 4
        }
        
        for index in  small..<small+large {
            asteroids.append(Asteroid(imageNamed: "asteroid_large.png"))
            asteroids[index].moveSpeed = 2
        }
        
        return asteroids
    }
}