import SpriteKit

class BonusGameScene: SKScene {
    
    var score = 0
    var scoreUpdateHandler: ((Int) -> Void)?
    var gameOverHandler: (() -> Void)?
    

    let goldenCloverCategory: UInt32 = 0x1 << 0
    let greenCloverCategory: UInt32 = 0x1 << 1
    

    var bonusGameTimer: Timer?
    var timeRemaining: Int = 10
    var gameEnded = false
    

    var background: SKSpriteNode?
    var darkOverlay: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        

        addBackground()
        addDarkOverlay()
        

        startBonusGame()
    }
    

    func addBackground() {
        let backgroundTexture = SKTexture(imageNamed: "backgroundBonus")
        background = SKSpriteNode(texture: backgroundTexture)
        
        background?.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background?.zPosition = -1
        background?.size = CGSize(width: size.width, height: size.height)
        
        if let background = background {
            addChild(background)
        }
    }
    

    func addDarkOverlay() {
        darkOverlay = SKSpriteNode(color: .black, size: CGSize(width: size.width, height: size.height))
        darkOverlay?.position = CGPoint(x: size.width / 2, y: size.height / 2)
        darkOverlay?.alpha = 0.5
        darkOverlay?.zPosition = 0
        
        if let darkOverlay = darkOverlay {
            addChild(darkOverlay)
        }
    }
    

    func startBonusGame() {
        timeRemaining = 10
        gameEnded = false
        bonusGameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        spawnBonusItems()
    }
    

    @objc func updateTimer() {
        guard !gameEnded else { return } 
        
        timeRemaining -= 1
        print("Time remaining: \(timeRemaining)")

        if timeRemaining <= 0 {
            print("Timer expired, ending game.")
            endBonusGame()
        } else if timeRemaining == 2 {
            print("Timer at 2 seconds, simulating click on green clover.")
            simulateGreenCloverTap()
        }
    }
    
   
    func simulateGreenCloverTap() {
        guard !gameEnded else { return }

        if let greenClover = children.first(where: {
            ($0 as? SKSpriteNode)?.physicsBody?.categoryBitMask == greenCloverCategory
        }) {
            endBonusGame()
            greenClover.removeFromParent()
        } else {
            endBonusGame()
        }
    }
    
   
    func spawnBonusItems() {
        let spawnAction = SKAction.run { [weak self] in
            guard let self = self, !self.gameEnded else { return }
            self.spawnRandomBonusItem()
        }
        
        let waitAction = SKAction.wait(forDuration: 1.0)
        let sequenceAction = SKAction.sequence([spawnAction, waitAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        run(repeatAction)
    }
    
    
    func spawnRandomBonusItem() {
        let randomX = CGFloat.random(in: 0...(size.width - 50))
        let randomY = CGFloat.random(in: 50...(size.height - 50))

        let itemType = ["goldenClover", "greenClover"].randomElement()!
        
        let item = SKSpriteNode(imageNamed: itemType)
        item.size = CGSize(width: 50, height: 50)
        item.position = CGPoint(x: randomX, y: randomY)

        item.physicsBody = SKPhysicsBody(circleOfRadius: item.size.width / 2)
        item.physicsBody?.categoryBitMask = getItemCategory(type: itemType)
        item.physicsBody?.contactTestBitMask = 0
        item.physicsBody?.collisionBitMask = 0
        item.physicsBody?.affectedByGravity = false
        item.physicsBody?.isDynamic = false
        
        addChild(item)
        
       
        let delayAction = SKAction.wait(forDuration: 2.0)
        let removeAction = SKAction.removeFromParent()
        let removeSequence = SKAction.sequence([delayAction, removeAction])
        item.run(removeSequence)
    }
    
    
    func getItemCategory(type: String) -> UInt32 {
        switch type {
        case "goldenClover": return goldenCloverCategory
        case "greenClover": return greenCloverCategory
        default: return 0
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameEnded else { return }

        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if let node = nodes(at: touchLocation).first, node.physicsBody != nil {
            if node.physicsBody!.categoryBitMask == goldenCloverCategory {
                score += 1
                scoreUpdateHandler?(score)
                node.removeFromParent()
            } else if node.physicsBody!.categoryBitMask == greenCloverCategory {
                endBonusGame()
                node.removeFromParent()
            }
        }
    }
    
    
    func endBonusGame() {
        guard !gameEnded else { return }

        print("Ending bonus game.")
        gameEnded = true
        bonusGameTimer?.invalidate()
        bonusGameTimer = nil
        
        
        let completedBonusGames = UserDefaults.standard.integer(forKey: "completedBonusGames")
        UserDefaults.standard.set(completedBonusGames + 1, forKey: "completedBonusGames")
        
        
        removeAllChildren()
        gameOverHandler?()
    }
}
