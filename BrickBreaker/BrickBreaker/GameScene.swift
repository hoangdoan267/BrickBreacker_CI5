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
    var bricks: [SKSpriteNode] = []
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addBackGround()
        addBreaker()
        addBricks()
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
        for (brickIndex, brick) in bricks.enumerate() {
            let brickFrame = brick.frame
            let ballFrame = ball.frame
            
            if CGRectIntersectsRect(brickFrame, ballFrame) {
                brick.removeFromParent()
                bricks.removeAtIndex(brickIndex)
            }
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
        //let flyDown = SKAction.moveByX(0, y: -20, duration: 0.1)
        //ball.runAction(SKAction.repeatActionForever(flyDown))
        
        
        let validate = SKAction.runBlock {
            let flyUp = SKAction.moveByX(0, y: 20, duration: 0.3)
            let flyDownz = SKAction.moveByX(0, y: -20, duration: 0.3)
            
            if self.ball.position.y <= self.breaker.position.y + self.breaker.frame.size.height + 20 {
                print("hihi")
                self.ball.runAction(SKAction.repeatActionForever(flyUp))
            }
            
            if self.ball.position.y >= (self.frame.height - self.ball.frame.size.height - 20) {
                self.ball.runAction(flyDownz)
            }
            
            print("run")
        }
        addChild(ball)

        self.ball.runAction(validate)
        //5
    }
    
    func addBricks() {

        print(self.frame.width)
        var count  = 64
        var checkX:CGFloat = 40
        var checkY:CGFloat = self.frame.maxY - 40
        
        while  count > 0 {
            let brick = SKSpriteNode(imageNamed: "brick_1.png")
            brick.size.height = 10
            brick.size.width = 30
            
            if checkX + brick.size.width + 1 > self.frame.width - 30 {
                checkX = 40
                checkY -= 11
            }
            
            brick.anchorPoint = CGPointZero
            brick.position = CGPoint(x: checkX, y: checkY)
            checkX += brick.size.width+1
            print(brick.position.x)
            bricks.append(brick)
            addChild(brick)

            count -= 1
        }
    }
}
