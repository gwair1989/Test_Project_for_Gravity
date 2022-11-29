//
//  GameScene.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 27.11.2022.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    private var isStartAnimate: Bool = false
    private var isAnimate: Bool = false
    
    private var circle: Circle!
    var touchesCount = 0
    let itemsPerRow: CGFloat = 5
    let inserts: CGFloat = 20
    var time: TimeInterval? = nil
    var nameNodes = [String]()
    var counterAnimation = 0
    
    let systemSoundID: SystemSoundID = 1029
    var sceneSize = CGSize.zero
    
    override init(size: CGSize) {
        super.init(size: size)
        sceneSize = size
        configureStartScreen(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isAnimate {
            let location = touches.first!.location(in: self)
            let node = self.atPoint(location)
            guard let nameNode = node.name else { return }
            if nameNode == nameNodes[touchesCount] && touchesCount < nameNodes.count {
                startAnimate(nameNode: nameNode)
                touchesCount += 1
            } else {
                AudioServicesPlaySystemSound(systemSoundID)
                showFailScene()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isAnimate  {
            if let time = self.time {
                if (currentTime - time) >= 2 {
                    self.time = currentTime
                    if counterAnimation < nameNodes.count {
                        startAnimate(nameNode: nameNodes[counterAnimation])
                        counterAnimation += 1
                    } else if counterAnimation == nameNodes.count {
                        isAnimate = false
                    }
                }
            } else {
                self.time = currentTime
                startAnimate(nameNode: nameNodes[counterAnimation])
                counterAnimation += 1
            }
        }
    }
    
    private func removeNode() {
        self.removeAllChildren()
        self.time = nil
        self.touchesCount = 0
        self.nameNodes = []
    }
    
    private func removeNodeIfSuccessfully() {
        if self.touchesCount == self.nameNodes.count {
            R.shared.rounds += 1
            showWinScene()
            removeNode()
        }
    }
    
    private func startAnimate(nameNode: String) {
        isAnimate = true
        if let node = childNode(withName: nameNode) {
            if !self.isStartAnimate {
                isStartAnimate = true
                animateNodes(node)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    private func configureStartScreen(size: CGSize) {
        spawnNode(size: size)
        isAnimate = true
    }
    
    private func spawnNode(size: CGSize) {
        let sizeNode = getSizeNode(sizeArea: size)
        let radius = sizeNode / 2
        let positions = getPositions(sizeArea: size, sizeNode: sizeNode)
        var positionIndexes: Set<Int> = []
        var count = 1
        for _ in positions {
            if count <= R.shared.rounds {
                let randomIndex = getRandomIndexPosition(positions: positions)
                if positionIndexes.insert(randomIndex).inserted {
                    count += 1
                }
            }
        }
        
        for index in positionIndexes {
            let position = positions[index]
            circle = Circle.populateCircle(radius: radius, position: position)
            circle.name = "Circle\(index)"
            nameNodes.append("Circle\(index)")
            addChild(circle)
        }
    }
    
    private func getRandomIndexPosition(positions: [CGPoint]) -> Int {
        let randomIndex = positions.indices.randomElement()
        return randomIndex ?? 0
    }
    
    private func getAvailableWidth(sizeArea: CGSize) -> CGFloat {
        let paddingWidth = inserts * (itemsPerRow + 1)
        let availableWidth = sizeArea.width - paddingWidth
        return availableWidth
    }
    
    private func getSizeNode(sizeArea: CGSize) -> CGFloat {
        let availableWidth = getAvailableWidth(sizeArea: sizeArea)
        let sizeNode = availableWidth / itemsPerRow
        return sizeNode
    }
    
    private func getNumberOfRows(sizeArea: CGSize) -> Int {
        let sizeNode = getSizeNode(sizeArea: sizeArea)
        let availabelHeight = sizeNode + inserts
        let numberOfLines = sizeArea.height / availabelHeight
        return Int(numberOfLines)
    }
    
    private func getPositions(sizeArea: CGSize, sizeNode: CGFloat) -> [CGPoint] {
        let numberOfRows = getNumberOfRows(sizeArea: sizeArea)
        var positions = [CGPoint]()
        var xPosition: CGFloat = CGFloat.zero
        var yPosition:CGFloat = CGFloat.zero
        let radiusNode = sizeNode / 2
        for numberOfRow in 1...numberOfRows {
            let numOfRow = CGFloat(numberOfRow)
            for numberItemInRow in 1...Int(itemsPerRow) {
                let numInRow = CGFloat(numberItemInRow)
                xPosition = ((inserts * numInRow) + (radiusNode * ((numInRow * 2) - 1)))
                yPosition = sizeArea.height - ((inserts * numOfRow) + (radiusNode * ((numOfRow * 2) - 1)))
                let positionsPerRow = CGPoint(x: xPosition, y: yPosition)
                positions.append(positionsPerRow)
            }
        }
        return positions
    }
    
    
    private func animateNodes(_ node: SKNode) {
        
        if isStartAnimate {
            // Анимация увеличения, а затем уменьшения
            let scaleUpAction = SKAction.scale(to: 1.3, duration: 0.2)
            let scaleDownAction = SKAction.scale(to: 1.0, duration: 0.2)
            
            // Формируем Sequence (последовательность) для SKAction
            let scaleActionSequence = SKAction.sequence([scaleUpAction,
                                                         scaleDownAction])
            
            // Создаем Action для повторения нашей последовательности
            let repeatAction = SKAction.repeat(scaleActionSequence, count: 2)
            
            // Запускаем итоговый SKAction
            node.run(repeatAction) {
                self.isStartAnimate = false
                self.removeNodeIfSuccessfully()
            }
        }
    }
    
    private func showWinScene() {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameScene = WinScene(size: sceneSize)
        gameScene.scaleMode = .resizeFill
        self.scene!.view?.presentScene(gameScene, transition: transition)
    }
    
    private func showFailScene() {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameScene = FailScene(size: sceneSize)
        gameScene.scaleMode = .resizeFill
        self.scene!.view?.presentScene(gameScene, transition: transition)
    }
    
}
