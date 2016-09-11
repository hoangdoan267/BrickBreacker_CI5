//
//  GameScene.swift
//  BrickBreaker
//
//  Created by SonVu on 9/11/16.
//  Copyright (c) 2016 SonVu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    //Nodes
    //let ball : SKSpriteNode!
    var brick : SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addBrick()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            //1
            let currentPosition = touch.locationInNode(self)
            let previousPosition = touch.previousLocationInNode(self)
            //2
            let dx = currentPosition.x - previousPosition.x
            let movementVector = CGPoint(x: dx, y: 0)
            //3
            let newPos = movementVector.add(brick.position)
            //4
            brick.position = newPos
            //validate
            if brick.position.x > self.frame.maxX {
                brick.position.x = self.frame.size.width - brick.frame.width / 2
            }
            if brick.position.x < 0 {
                brick.position.x = brick.frame.width / 2
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //ADD BRICK
    func addBrick()  {
        //1
        brick = SKSpriteNode(imageNamed: "brick.jpg")
        //2 size
        brick.size.height = 30
        brick.size.width = 80
        //3 position
        brick.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.minY + 100)
        //4
        addChild(brick)
    }
}
