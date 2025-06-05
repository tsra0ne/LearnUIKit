//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let slider = UISlider()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 5
        slider.minimumTrackTintColor = .systemGreen
        slider.maximumTrackTintColor = .systemGray2
        slider.thumbTintColor = .white
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderDragged), for: .valueChanged)
        
//        slider.minimumValueImage = UIImage(systemName: "minus.circle")
//        slider.maximumValueImage = UIImage(systemName: "plus.circle")
        
        view.addSubviews(label, slider)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
        }
        slider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func sliderDragged(_ sender: UISlider) {
        label.text = "\(Int(sender.value))"
    }

}

