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
    var tapToRestartLabel = SKLabelNode(fontNamed: "Chalkduster")
    let player = SKShapeNode(circleOfRadius: 20)
    var highScore = 0
    var isPlayerDead = false
    
    var highScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    var topHighScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    let sceneEdgeCategory: UInt32 = 1 << 0
    let spikeCategory: UInt32 = 1 << 1
    let playerCategory: UInt32 = 1 << 2
    var leftSpikes: [SKShapeNode] = []
    
    var wallContact = false
    
    let maxSpeed = CGVector(dx: 100, dy: 100)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        //backgroundColor = SKColor.black
        hudNode = SKNode()
        addChild(hudNode)
        
        highScoreLabel.text = String(highScore)
        highScoreLabel.fontSize = 70
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        addChild(highScoreLabel)
        
        topHighScoreLabel.text = String(highScore)
        topHighScoreLabel.fontSize = 15
        topHighScoreLabel.fontColor = SKColor.white
        topHighScoreLabel.position = CGPoint(x: 50, y: 40)
        addChild(topHighScoreLabel)
        
        
        startGameLabel.text = "tap to play"
        startGameLabel.fontSize = 30
        startGameLabel.fontColor = SKColor.white
        startGameLabel.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        startGameLabel.isUserInteractionEnabled = true
        hudNode.addChild(startGameLabel)
        
        
        tapToRestartLabel.text = "tap to restart"
        tapToRestartLabel.fontSize = 30
        tapToRestartLabel.fontColor = SKColor.white
        tapToRestartLabel.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        tapToRestartLabel.isUserInteractionEnabled = true
        
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
        player.physicsBody?.categoryBitMask = playerCategory
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        //spike.position = CGPoint(x: frame.midX - 20, y: frame.midY - 20)
//        spike.zRotation = 15
        
        addChild(player)
        
        for i in 1...9{
            
            // Brick positioning
            var topXPos = size.width / 6 //CGFloat
            var topXPosInt = Int(topXPos) * (i + 1) - 80// Int
            topXPos = CGFloat(topXPosInt) // Convert to CGFloat again
            var topYPos = size.height
            var botYPos = CGFloat(0)
            
            var rightLeftSpikesPosY = Int(size.height / 10) * (i + 1) - 40
            var rightLeftSpikesPosYCGF = CGFloat(rightLeftSpikesPosY)
            
            
            // Brick settings
            let topSpike = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
            topSpike.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
            topSpike.physicsBody?.isDynamic = false
            topSpike.zRotation = CGFloat(Double.pi) / 4
            topSpike.physicsBody?.categoryBitMask = spikeCategory
            topSpike.physicsBody?.contactTestBitMask = playerCategory
            
            let botSpike = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
            botSpike.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
            botSpike.physicsBody?.isDynamic = false
            botSpike.zRotation = CGFloat(Double.pi) / 4
            botSpike.physicsBody?.categoryBitMask = spikeCategory
            botSpike.physicsBody?.contactTestBitMask = playerCategory
            
            let rightSpike = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
            rightSpike.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
            rightSpike.physicsBody?.isDynamic = false
            rightSpike.zRotation = CGFloat(Double.pi) / 4
            rightSpike.physicsBody?.categoryBitMask = spikeCategory
            rightSpike.physicsBody?.contactTestBitMask = playerCategory
            
            
            topSpike.position = CGPoint(x: topXPos, y:topYPos)
            botSpike.position = CGPoint(x: topXPos, y:botYPos)
            rightSpike.position = CGPoint(x: size.width, y: rightLeftSpikesPosYCGF)
//            leftSpike.position = CGPoint(x: 0, y: rightLeftSpikesPosYCGF)

            
            self.addChild(topSpike)
            self.addChild(botSpike)

            
        }

    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        if isPlayerDead == false{
            print("touches began")
            
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
            
        }else if isPlayerDead == true{
            
            tapToRestartLabel.removeFromParent()
            //addChild(player)
            player.position = CGPoint(x: frame.midX, y: frame.midY)
            player.physicsBody?.isDynamic = true
            player.physicsBody?.velocity.dx = 100
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
            highScore = 0
            highScoreLabel.text = String(highScore)
            isPlayerDead = false
            print("else dead")
        }
        

        
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = sceneEdgeCategory
        
        //player.physicsBody?.contactTestBitMask = sceneEdgeCategory
        self.physicsBody?.contactTestBitMask = playerCategory
        
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        
        let firstBody = contact.bodyA
        let numberOfSprites = 6
        
        if firstBody.categoryBitMask == sceneEdgeCategory && wallContact == false{
            wallContact = true
            //self.physicsWorld.gravity = CGVector(dx: -1, dy: -2)
            player.physicsBody?.velocity.dx = -200
            highScore += 1
            print("if wall contact")
            self.updateHighScore()
            self.updateTopHighScore()
            
            for i in 0..<numberOfSprites {
                let randomNumber = Int.random(in: 2 ... 6)
                var leftSpike = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
                var rightLeftSpikesPosY = Int(size.height / 10) * (i + randomNumber) - 40
                var rightLeftSpikesPosYCGF = CGFloat(rightLeftSpikesPosY)
                leftSpike.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
                leftSpike.physicsBody?.isDynamic = false
                leftSpike.zRotation = CGFloat(Double.pi) / 4
                leftSpike.physicsBody?.categoryBitMask = spikeCategory
                leftSpike.physicsBody?.contactTestBitMask = playerCategory
                leftSpikes.append(leftSpike)
                leftSpike.position = CGPoint(x: 0, y: rightLeftSpikesPosYCGF)
                addChild(leftSpike)
            }

        } else if firstBody.categoryBitMask == spikeCategory && isPlayerDead == false{
            print("spike contact, dead")
            
            player.physicsBody?.isDynamic = false
            isPlayerDead = true
            addChild(tapToRestartLabel)
            
            
        }else{
            wallContact = false
            //self.physicsWorld.gravity = CGVector(dx: 1, dy: -2)
            player.physicsBody?.velocity.dx = 200
            print("else wall contact")
            
            removeChildren(in: leftSpikes)
            highScore += 1
            //print(highScore)
            self.updateHighScore()
            self.updateTopHighScore()
            
        }
    }

    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func updateHighScore(){
        highScoreLabel.text = String(highScore)
        //print(highScore)
    }
    
    func updateTopHighScore(){
        var topHighScore = 0
        if highScore >= topHighScore{
            topHighScore = highScore
            topHighScoreLabel.text = "Record: \(topHighScore)"
        }
    }
}
