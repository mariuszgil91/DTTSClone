//
//  GameScene.swift
//  DTTSClone
//
//  Created by Mariusz Gil on 21/02/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var backgroundNode: SKNode!
    var midgroundNode: SKNode!
    var foregroundNode: SKNode!
    var hudNode: SKNode!
    var startGameLabel = SKLabelNode(fontNamed: "Chalkduster")
    let player = SKShapeNode(circleOfRadius: 20)
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        //backgroundColor = SKColor.black
        hudNode = SKNode()
        addChild(hudNode)
        
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
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
        addChild(player)
        
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
//        let touch:UITouch = touches.first!
//        let positionInScene = touch.location(in: self)
//        let touchedNode = self.atPoint(positionInScene)
//
        // 2
        // Remove the Tap to Start node
        startGameLabel.removeFromParent()
        
        // 3
        // Start the player by putting them into the physics simulation
        player.physicsBody?.isDynamic = true
        
        // 4
        //physicsWorld.gravity = CGVector(dx: 0.0, dy: 2.0)
        //player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
        
        print("touch")
        
        for _ in touches {
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 15))
        }
        
    }
    
    
}
