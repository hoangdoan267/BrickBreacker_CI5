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
    let goc_quay: CGFloat = 90 * CGFloat(M_PI)/180
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addBackGround()
        addBreaker()
        addBricks()
        addBall()
        self.physicsWorld.gravity = CGVectorMake(0,0);
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
    
    var lastUpdateTimeInterval: CFTimeInterval = 0
    
    override func update(currentTime: CFTimeInterval) {
        let r:CGFloat = 45 * CGFloat(M_PI)/180
        print(r)
        let dX: CGFloat = r * cos(self.ball.zRotation)
        let dY: CGFloat = r * sin(self.ball.zRotation)
        let dV: CGFloat = r * sin(self.ball.zRotation * 2)
        for index in (bricks.count-1).stride(through: 0, by: -1) {
            let brick = bricks[index]
            let brickFrame = brick.frame
            let ballFrame = ball.frame

            
            if CGRectIntersectsRect(brickFrame, ballFrame) {
                
                brick.removeFromParent()
                bricks.removeAtIndex(index)
                self.ball.physicsBody!.applyImpulse(CGVectorMake(dX, dY))
                self.ball.physicsBody!.velocity.dy = -200
                
            }
        }
        
        if (self.ball.position.y <= self.breaker.position.y + self.breaker.frame.size.height)
            && (self.ball.position.x >= self.breaker.position.x)
            && (self.ball.position.x + self.ball.frame.width <= self.breaker.position.x + self.breaker.frame.width)
        {
            print("flyup")
            self.ball.physicsBody!.velocity.dy = 200
        }
        
        if self.ball.position.x >= self.frame.width - self.ball.frame.width {
            self.ball.physicsBody!.applyImpulse(CGVectorMake(dX, dY))
            self.ball.physicsBody!.velocity.dx = -200
        }
        
        if self.ball.position.x <= self.ball.frame.width {
            self.ball.physicsBody!.applyImpulse(CGVectorMake(dX, dY))
            self.ball.physicsBody!.velocity.dx = +200
        }
        
        if self.ball.position.y >= (self.frame.height - self.ball.frame.size.height) {
            print("flydown")
            self.ball.physicsBody!.velocity.dy = -200
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
//        breaker.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(10, 100))
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
        ball.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(10, 10))
        
        
        //4 action
        //let flyDown = SKAction.moveByX(0, y: -20, duration: 0.1)
        //ball.runAction(SKAction.repeatActionForever(flyDown))
        
        
        addChild(ball)
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
            bricks.append(brick)
            addChild(brick)

            count -= 1
        }
    }
}
