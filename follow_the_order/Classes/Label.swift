//
//  Label.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 29.11.2022.
//
import SpriteKit

class Label: SKLabelNode {
    static func populateBackground(position: CGPoint, fontSize: CGFloat) -> Label {
        let label = Label()
        label.fontColor = .red
        label.fontName = "AmericanTypewriter-Bold"
        label.fontSize = fontSize
        label.zPosition = 2
        label.numberOfLines = 0
        label.name = "titleToStart"
        label.position = position
        return label
    }
}
