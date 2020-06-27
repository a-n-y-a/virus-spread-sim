import PlaygroundSupport
import SpriteKit

// Parameters to change how the simulation works
struct SimParameters {
    static let numberOfInfectedPeople = 2 // Defines number of infected people when simulation starts
    static let numberOfHealthyPeople = 30 // Defines number of healthy people when simulation starts
    static let initialSpeedBump = 3 // Maximum value of vector impulse initially added to each ball
    static let speedBumpOnContact = 1 // Maximum value of vector impulse added to each ball when they come into contact
    static let ballInfectionDuration = 10.0 // Number of seconds after which an infected ball recovers 
}

// Main class
public class MainScene: SKScene, SKPhysicsContactDelegate {
    
    // Created balls are stored in the array
    var balls = [SKSpriteNode]()
    
    // This function is called when the simulation appears on the screen
    public override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0.0
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1.0
        backgroundColor = .lightGray
        
        // Show the intro text and the start button
        let startLabel = makeLabel(name: "startLabel", text: labelText(), x: Int(frame.midX), y: Int(frame.midY - 200))
        addChild(startLabel)
    }
    
    // This function is called on each contact. BodyA and BodyB represent the balls which bump each other
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "SickBall" && contact.bodyB.node?.name == "HealthyBall" {
            makeSick(ball: contact.bodyB.node as! SKSpriteNode)
        } else if contact.bodyA.node?.name == "HealthyBall" && contact.bodyB.node?.name == "SickBall" {
            makeSick(ball: contact.bodyA.node as! SKSpriteNode)
        }
        // Apply small random vector impulse to keep the balls moving
        contact.bodyA.node?.physicsBody?.applyImpulse(randomVector(speed: SimParameters.speedBumpOnContact))
        contact.bodyB.node?.physicsBody?.applyImpulse(randomVector(speed: SimParameters.speedBumpOnContact))
    }
    
    // This fucntion is called on each touch
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            
            // If node is a ball then switch social distancing mode
            if let ball = nodes(at: location).first as? SKSpriteNode {
                if ball.name == "HealthyBall" {
                    addHalo(ball: ball)
                    ball.name = "DistancingBall"
                } else if ball.name == "DistancingBall" {
                    removeHalo(ball: ball)
                    ball.name = "HealthyBall"
                }
            }
            // If node is a label then start the simulation
            else if let label = nodes(at: location).first as? SKLabelNode {
                // Remove the label from the screen
                label.removeFromParent()
                showBalls()
                // Apply initial random force to all balls
                for ball in balls {
                    ball.physicsBody?.applyImpulse(randomVector(speed: SimParameters.initialSpeedBump))
                }
            }
        }
    }
}


