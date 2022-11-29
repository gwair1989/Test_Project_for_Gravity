//
//  FailScene.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 29.11.2022.
//

import SpriteKit

final class FailScene: SKScene {
    
    private var sceneSize = CGSize.zero
    private var startButton: MainButton!
    private var failLabel: Label!
    
    override init(size: CGSize) {
        super.init(size: size)
        sceneSize = size
        configureStartScreen(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStartScreen(size: CGSize) {
        backgroundColor = .white
        configStartButton(screenSize: size)
        configTitle()
    }
    
    private func configStartButton(screenSize: CGSize) {
        guard let color1 = UIColor(named: "Color1"),
              let color2 = UIColor(named: "Color2")
        else { return }
        startButton = MainButton.populateButton(position: CGPoint(x: size.width / 2, y: size.height / 3),
                                                    color1: color1,
                                                    color2: color2,
                                                    title: "Back to Game")
        startButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(tapStartButton))
        addChild(startButton)
        
    }

    
    @objc func tapStartButton() {
        showGameScene()
        print("Tap Start Button")
    }
    
    private func configTitle() {
        failLabel = Label.populateBackground(position: CGPoint(x: size.width / 2, y: size.height / 1.7),
                                             fontSize: 40)
        failLabel.text = "Oooops"
        addChild(failLabel)
    }
    
    private func showGameScene() {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameScene = GameScene(size: sceneSize)
        gameScene.scaleMode = .resizeFill
        self.scene!.view?.presentScene(gameScene, transition: transition)
    }
    
    
}
