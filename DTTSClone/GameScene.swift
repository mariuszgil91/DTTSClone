//
//  GameScene.swift
//  DTTSClone
//
//  Created by Mariusz Gil on 21/02/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var backgroundNode: SKNode!
    var midgroundNode: SKNode!
    var foregroundNode: SKNode!
    var hudNode: SKNode!
    var startGameLabel = SKLabelNode(fontNamed: "Chalkduster")
    let player = SKShapeNode(circleOfRadius: 20)
//    let spike = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
    
    let sceneEdgeCategory: UInt32 = 1 << 0
    let playerCategory: UInt32 = 1 << 1
    
    var edgeContact = false
    
    let maxSpeed = CGVector(dx: 100, dy: 100)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        //backgroundColor = SKColor.black
        hudNode = SKNode()
        addChild(hudNode)
        
        startGameLabel.text = "tap to play"
        startGameLabel.fontSize = 30
        startGameLabel.fontColor = SKColor.green
        startGameLabel.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        startGameLabel.isUserInteractionEnabled = true
        hudNode.addChild(startGameLabel)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.isDynamic = false
        player.physicsBody?.allowsRotation = false
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        player.physicsBody?.restitution = 1.0
        player.physicsBody?.friction = 0.0
        player.physicsBody?.angularDamping = 0.0
        player.physicsBody?.linearDamping = 0.0
        player.isUserInteractionEnabled = true
        player.physicsBody?.velocity.dx = 100
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        //spike.position = CGPoint(x: frame.midX - 20, y: frame.midY - 20)
//        spike.zRotation = 15
        
        addChild(player)
        
        for i in 1...8{
            
            // Brick settings
            let topSpike = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
            topSpike.physicsBody?.isDynamic = false
            topSpike.zRotation = CGFloat(Double.pi) / 4
            
            let botSpike = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
            botSpike.physicsBody?.isDynamic = false
            botSpike.zRotation = CGFloat(Double.pi) / 4
            
            // Brick positioning
            var topXPos = size.width / 6 //CGFloat
            var topXPosInt = Int(topXPos) * (i + 1) - 100// Int
            topXPos = CGFloat(topXPosInt) // Convert to CGFloat again
            var topYPos = size.height
            
            var botYPos = CGFloat(0)
            
            topSpike.position = CGPoint(x: topXPos, y:topYPos)
            botSpike.position = CGPoint(x: topXPos, y:botYPos)
            
            self.addChild(topSpike)
            self.addChild(botSpike)
            
            print("x position: \(topXPos)")
            print("y position: \(botYPos)")
            
        }
        //addChild(spike)
    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {

        startGameLabel.removeFromParent()
        player.physicsBody?.isDynamic = true
        //print("screen touched")
        
        for _ in touches {
            
            if ((player.physicsBody?.velocity.dy)! < CGFloat(0)) {
              player.physicsBody?.velocity.dy = 0
            } else{
                //print("lece do góry")
            }
            
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
            
        }
        
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = sceneEdgeCategory
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = sceneEdgeCategory
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        
        
        if edgeContact == true {
            edgeContact = false
            //self.physicsWorld.gravity = CGVector(dx: -1, dy: -2)
            player.physicsBody?.velocity.dx = -200
        } else {
            edgeContact = true
            //self.physicsWorld.gravity = CGVector(dx: 1, dy: -2)
            player.physicsBody?.velocity.dx = 200
        }

    }

    override func update(_ currentTime: TimeInterval) {

    }
}
