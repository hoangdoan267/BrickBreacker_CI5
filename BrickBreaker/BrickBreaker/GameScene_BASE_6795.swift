//
//  GameScene.swift
//  breakerBreaker
//
//  Created by SonVu on 9/11/16.
//  Copyright (c) 2016 SonVu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    //Nodes
    //let ball : SKSpriteNode!
    var breaker : SKSpriteNode!
    var ball : SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addBackGround()
        addBreaker()
        addBall()
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
            let newPos = movementVector.add(breaker.position)
            //4
            breaker.position = newPos
            //validate
            if breaker.position.x > self.frame.maxX {
                breaker.position.x = self.frame.size.width - breaker.frame.width / 2
            }
            if breaker.position.x < 0 {
                breaker.position.x = breaker.frame.width / 2
            }
        }
    }
    
    
    //UPDATE
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //1
        let breakerFrame = breaker.frame
        let ballFrame = ball.frame
        //2
        if CGRectIntersectsRect(breakerFrame, ballFrame) {
            let flyUp = SKAction.moveByX(0, y: 20, duration: 0.3)
            ball.runAction(SKAction.repeatActionForever(flyUp))
        }
        if ball.position.y >= (self.frame.height - ball.frame.size.height - 20) {
            let flyDownz = SKAction.moveByX(0, y: -20, duration: 0.3)
            ball.runAction(SKAction.repeatActionForever(flyDownz))
        }
    }
    
    //ADD breaker
    func addBreaker()  {
        //1
        breaker = SKSpriteNode(imageNamed: "breaker.png")
        //2 size
        breaker.size.height = 10
        breaker.size.width = 100
        //3 position
        breaker.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.minY + 40)
        //4
        addChild(breaker)
    }
    
    //ADD BACKGROUND
    func addBackGround() {
        //1
        let backGround = SKSpriteNode(imageNamed: "launch_background.png")
        //2
        backGround.anchorPoint = CGPointZero
        //3
        addChild(backGround)
    }
    
    //ADD BALL
    func addBall()  {
        //1
        ball = SKSpriteNode.init(imageNamed: "ball_1.png")
        //2 size
        ball.size.width = 10
        ball.size.height = 10
        //3 position
        ball.position.x = breaker.position.x
        ball.position.y = breaker.position.y + breaker.frame.height
        //4 action
        let flyDown = SKAction.moveByX(0, y: -20, duration: 0.1)
        ball.runAction(SKAction.repeatActionForever(flyDown))
        //5
        addChild(ball)
    }
}
