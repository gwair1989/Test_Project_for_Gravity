//
//  ViewController.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 27.11.2022.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func loadView() {
        self.view = SKView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let safe = view.safeAreaLayoutGuide.layoutFrame
        let scene = StartScene(size: CGSize(width: safe.width, height: safe.height))
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

