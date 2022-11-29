//
//  StartScene.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 29.11.2022.
//

import SpriteKit

class StartScene: SKScene {
    
    var sceneSize = CGSize.zero
    private var startButton: MainButton!
    private var titleToStart: Label!
    var counterAnimation = 3
    var time: TimeInterval? = nil
    var isStartAnimation = false
    
    
    override init(size: CGSize) {
        super.init(size: size)
        sceneSize = size
        configureStartScreen(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isStartAnimation {
            if let time {
                if (currentTime - time) >= 1 {
                    self.time = currentTime

                    titleToStart.removeFromParent()
                    configTitleToStart()
                    self.counterAnimation -= 1
                }
            } else {
                self.time = currentTime
                configTitleToStart()
                self.counterAnimation -= 1
            }
            
        }
        
        if counterAnimation == -3 {
            titleToStart.removeFromParent()
            isStartAnimation = false
            showGameScene()
        }
        
    }
    
    
    
    private func configureStartScreen(size: CGSize) {
        backgroundColor = .white
        configStartButton(screenSize: size)
    }
    
    private func configStartButton(screenSize: CGSize) {
        guard let color1 = UIColor(named: "Color1"),
              let color2 = UIColor(named: "Color2")
        else { return }
        
        startButton = MainButton.populateButton(position: CGPoint(x: size.width / 2, y: size.height / 3),
                                                    color1: color1,
                                                    color2: color2,
                                                    title: "Start Game")
        startButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(tapStartButton))
        addChild(startButton)
    }
    
    @objc func tapStartButton() {
        isStartAnimation = true
        print("Tap Start Button")
    }
    
    func configTitleToStart() {
        titleToStart = Label.populateBackground(position: CGPoint(x: size.width / 2, y: size.height / 1.5),
                                                fontSize: 200)
        addChild(titleToStart)
        animateTitle()
    }
    
    func animateTitle() {
        if counterAnimation >= 0 {
            titleToStart.text = "\(counterAnimation)"
        } else {
            titleToStart.text = "GO!"
        }
        
        let scaleDownAction = SKAction.scale(to: 0.0, duration: 1)
        titleToStart.run(scaleDownAction)
    }
    
    private func showGameScene() {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameScene = GameScene(size: sceneSize)
        gameScene.scaleMode = .resizeFill
        self.scene!.view?.presentScene(gameScene, transition: transition)
    }
    
    
    
}
