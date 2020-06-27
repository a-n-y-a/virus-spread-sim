import SpriteKit

extension MainScene {
    
    // The intro label contains the text and the <Start Simulation> "button"
    // It is not a real button
    // Taping anywhere on the label has the effect of staring the simulation
    // Formating text in Swift is tedious :(
    
    func labelText() -> NSMutableAttributedString {
        
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.alignment = .center
        paragraphStyle1.lineBreakMode = .byClipping
        
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.alignment = .center
        paragraphStyle2.lineSpacing = 14
        paragraphStyle2.lineBreakMode = .byClipping
        
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 22),
            .foregroundColor: UIColor.black,
            .backgroundColor: UIColor.lightGray,
            .paragraphStyle: paragraphStyle1,
        ]
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25),
            .foregroundColor: UIColor.blue,
            .backgroundColor: UIColor.lightGray,
            .paragraphStyle: paragraphStyle1,
        ]
        let thirdAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 40),
            .foregroundColor: UIColor.red,
            .backgroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle2,
        ]
        
        let labelText = NSMutableAttributedString(string: "This is a simple simulation, which aims to demonstrate\nthe importance of social distancing during the current global pandemic.\nOnce you click Start Simulation the simulation will begin and you will see\nmultiple balls floating around the screen. These balls represent people.\nThe green ball represents a healthy person, the red represents an infected person\nwhich after ten seconds will turn blue or recover, meaning they can no longer infect other balls.\nWhen an infected ball touches a healthy ball, it will infect it, hence representing the spread of the virus.\nIf you tap on a healthy ball, a halo will apear around it protecting it from the infected balls\nand stopping it from moving. This represents the act of social distancing.\n\n", attributes: firstAttributes)
        let labelText2 = NSAttributedString(string: "Please turn off the Playgrounds <Enable Results> toggle.\nThis will increase performance and make the simultion run smoothy.", attributes: secondAttributes)
        let labelText3 = NSAttributedString(string: "◀︎ START SIMULATION ▶︎\n", attributes: thirdAttributes)
        
        labelText.append(labelText3)
        labelText.append(labelText2)
        
        return labelText
    }
    
    func makeLabel(name: String, text: NSMutableAttributedString, x: Int, y: Int) -> SKLabelNode {
        let label = SKLabelNode()
        label.name = name
        label.numberOfLines = 5
        label.attributedText = text
        label.position = CGPoint(x: x, y: y)
        label.zPosition = 10
        return label
    }
}

