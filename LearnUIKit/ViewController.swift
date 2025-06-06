//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        datePicker.tintColor = .systemBlue
        datePicker.backgroundColor = .systemGray6
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        NSLog("Selected date: \(formatter.string(from: sender.date))")
    }

}

