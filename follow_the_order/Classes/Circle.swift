//
//  Circle.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 29.11.2022.
//

import SpriteKit

class Circle: SKShapeNode {
    static func populateCircle(radius: CGFloat, position: CGPoint) -> Circle {
        let node = Circle(circleOfRadius: radius)
        node.position = position
        node.strokeColor = SKColor.clear
        node.fillColor = SKColor.white
        if let color1 = UIColor(named: "Color1"),
           let color2 = UIColor(named: "Color2") {
            node.fillTexture = SKTexture(size: CGSize(width: radius, height: radius), color1: CIColor(color: color1), color2: CIColor(color: color2), direction: GradientDirection.up)
        }
        node.zPosition = 2
        node.isAntialiased = false
        return node
    }
}
