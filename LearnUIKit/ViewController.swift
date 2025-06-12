//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let uiView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    func setupUI() {
        uiView.backgroundColor = .systemPurple
        view.addSubview(uiView)
        uiView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
        addLongPressGesture()
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggeredTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        uiView.addGestureRecognizer(tapGesture)
    }
    
    @objc func triggeredTapGesture(_ sender: UITapGestureRecognizer) {
        NSLog("triggeredTapGesture")
    }
    
    func addPinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(triggeredPinchGesture))
        uiView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func triggeredPinchGesture(_ sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
        if sender.state == .began || sender.state == .changed {
            let scale = sender.scale
            sender.view?.transform = sender.view!.transform.scaledBy(x: scale, y: scale)
            sender.scale = 1.0
            NSLog("Pinched with scale: \(scale)")
        }
    }
    
    func addRotationGesture() {
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(triggeredRotationGesture))
        uiView.addGestureRecognizer(rotationGesture)
    }
    
    @objc func triggeredRotationGesture(_ sender: UIRotationGestureRecognizer) {
        guard sender.view != nil else { return }
        if sender.state == .began || sender.state == .changed {
            let rotation = sender.rotation
            sender.view?.transform = sender.view!.transform.rotated(by: rotation)
            sender.rotation = 0.0
            NSLog("Rotated by: \(rotation) radians")
        }
    }
    
    func addSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(triggeredSwipeGesture))
        swipeGesture.direction = .right
        uiView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func triggeredSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        NSLog("Swiped \(direction == .right ? "right": "other")")
    }
    
    func addLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(triggeredLongPressGesture))
        uiView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func triggeredLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            NSLog("Long press began at \(sender.location(in: uiView))")
        } else if sender.state == .ended {
            NSLog("Long press ended")
        }
    }
    
}

