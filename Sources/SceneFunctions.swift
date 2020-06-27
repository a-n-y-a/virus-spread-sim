import SpriteKit

extension MainScene {
    
    var ballSize: CGFloat { frame.height < frame.width ? frame.height / 24 : frame.width / 24 }
    var haloRatio: CGFloat { 2 }
    
    // Create a new ball
    func makeBall(name: String, image: UIImage, location: CGPoint, halo: Bool) -> SKSpriteNode {
        let texture = SKTexture(image: image)
        let ball = SKSpriteNode(texture: texture, size: CGSize(width: ballSize, height: ballSize))
        ball.name = name
        if halo {
            ball.showCircle(radius: (ballSize / 2) * haloRatio)
            ball.physicsBody = SKPhysicsBody(circleOfRadius: (ballSize / 2) * haloRatio)
            ball.physicsBody?.isDynamic = false
        } else {
            ball.physicsBody = SKPhysicsBody(circleOfRadius: (ballSize / 2))
        }
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.position = location
        applyPhysics(ball: ball)
        return ball
    }
    
    // Apply initial physics parameters
    func applyPhysics(ball: SKSpriteNode) {
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.angularDamping = 0.0
        ball.physicsBody?.linearDamping = 0.0
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.allowsRotation = false
    }
    
    // Create cirlce around a ball
    func addHalo(ball: SKSpriteNode) {
        ball.showCircle(radius: (ballSize / 2) * haloRatio)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: (ballSize / 2) * haloRatio)
        ball.physicsBody?.isDynamic = false
    }
    
    // Remove circle around a ball
    func removeHalo(ball: SKSpriteNode) {
        ball.removeAllChildren()
        ball.physicsBody?.isDynamic = true
        ball.physicsBody = SKPhysicsBody(circleOfRadius: (ballSize / 2))
        applyPhysics(ball: ball)
        ball.physicsBody?.applyImpulse(randomVector(speed: 3))
    }
    
    // Create a random position
    func randomPosition() -> CGPoint {
        let randX = CGFloat.random(in: 0...frame.width)
        let randY = CGFloat.random(in: 0...frame.height)
        return CGPoint(x: randX, y: randY)
    }
    
    // Create a random vector for intial impulse
    func randomVector(speed: Int) -> CGVector {
        let maxSpeed = CGFloat(speed)
        let randDx = CGFloat.random(in: -maxSpeed...maxSpeed)
        let randDy = CGFloat.random(in: -maxSpeed...maxSpeed)
        return CGVector(dx: randDx, dy: randDy)
    }
    
    // Infect a ball
    func makeSick(ball: SKSpriteNode) {
        ball.name = "SickBall"
        ball.texture = SKTexture(image: #imageLiteral(resourceName: "ballRed.png"))
        let makeRecovered = SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "ballBlue.png")))
        let nameRecovered = SKAction.run {
            ball.name = "RecoveredBall"
        }
        let wait = SKAction.wait(forDuration: SimParameters.ballInfectionDuration)
        let sequence = SKAction.sequence([wait, makeRecovered, nameRecovered])
        ball.run(sequence)
    }
    
    // Create all balls to be shown on the screen
    func showBalls() {
        for _ in 0...(SimParameters.numberOfInfectedPeople - 1) {
            let ball = makeBall(name: "SickBall", image: #imageLiteral(resourceName: "ballRed.png"), location: randomPosition(), halo: false )
            addChild(ball)
            balls.append(ball)
        }
        for _ in 0...(SimParameters.numberOfHealthyPeople - 1) {
            let ball = makeBall(name: "HealthyBall", image: #imageLiteral(resourceName: "ballGreen.png"), location: randomPosition(), halo: false)
            addChild(ball)
            balls.append(ball)
        }
    }
}

// Create a circular shape as a child of a node
extension SKNode {
    func showCircle(radius: CGFloat) {
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.zPosition = -3
        circle.strokeColor = UIColor(cgColor: #colorLiteral(red: 0.23921568627450981, green: 0.6745098039215687, blue: 0.9686274509803922, alpha: 1.0)).withAlphaComponent(0.4)
        circle.fillColor = UIColor(cgColor: #colorLiteral(red: 0.23921568627450981, green: 0.6745098039215687, blue: 0.9686274509803922, alpha: 1.0)).withAlphaComponent(0.4)
        addChild(circle)
    } 
}

