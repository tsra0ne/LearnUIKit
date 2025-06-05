//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let progressView = UIProgressView(progressViewStyle: .default)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        simulateProgress()
    }

    func setupUI() {
        progressView.progress = 0
        progressView.progressTintColor = .systemBlue
        progressView.trackTintColor = .systemGray2
        
        view.addSubview(progressView)
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
    }
    
    func simulateProgress() {
        var currentProgress: Float = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            currentProgress += 0.05
            self.progressView.setProgress(currentProgress, animated: true)
            if currentProgress >= 1.0 {
                timer.invalidate()
            }
        }
    }

}

