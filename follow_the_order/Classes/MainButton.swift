//
//  MainButton.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 29.11.2022.
//

import SpriteKit

class MainButton: ButtonNode {
    static func populateButton(position: CGPoint, color1: UIColor, color2: UIColor, title: String) -> MainButton {
        let width = UIScreen.main.bounds.size.width - 150.0
        let height = 75.0
        let sizeButton = CGSize(width: width, height: height)
        let normalTexture = SKTexture(size: sizeButton, color1: CIColor(color: color1), color2: CIColor(color: color2), direction: GradientDirection.up)
        
        let selectedTexture = SKTexture(size: sizeButton, color1: CIColor(color: color2), color2: CIColor(color: color1), direction: GradientDirection.up)
        
        let button = MainButton(normalTexture: normalTexture,
                               selectedTexture: selectedTexture, title: title, disabledTexture: nil)
        button.size = sizeButton
        button.zPosition = 2
        button.position = position
        return button
    }
}
