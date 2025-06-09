//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {
    
    var data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    var collectionView: UICollectionView!
    let addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        title = "Collection"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.register(SwiftUICustomCell.self, forCellWithReuseIdentifier: SwiftUICustomCell.identifier)
        
        addButton.setTitle("Add Item", for: .normal)
        addButton.configuration = .filled()
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        
        view.addSubviews(addButton, collectionView)
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func addClicked() {
        data.append("Item \(data.count + 1)")
        let indexPath = IndexPath(row: data.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwiftUICustomCell.identifier, for: indexPath) as! SwiftUICustomCell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            NSLog("\(selectedItems.map { data[$0.item] })")
        }
    }
}

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCell"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        contentView.addSubview(label)
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }
    }
    
    func configure(with text: String) {
        label.text = text
    }
}

struct CustomCellView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
    }
}

class SwiftUICustomCell: UICollectionViewCell {
    
    static let identifier = "SwiftUICell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        contentConfiguration = UIHostingConfiguration {
            CustomCellView(text: text)
        }
        .margins(.all, .zero)
    }
}

class DDSViewController: UIViewController {
    
    var data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    var collectionView: UICollectionView!
    let addButton = UIButton()
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureDataSource()
        applySnapshot()
    }
    
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section ,String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    
    func setupUI() {
        title = "Collection"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.register(SwiftUICustomCell.self, forCellWithReuseIdentifier: SwiftUICustomCell.identifier)
        
        addButton.setTitle("Add Item", for: .normal)
        addButton.configuration = .filled()
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        
        view.addSubviews(addButton, collectionView)
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwiftUICustomCell.identifier, for: indexPath) as! SwiftUICustomCell
            cell.configure(with: item)
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func addClicked() {
        data.append("Item \(data.count + 1)")
        applySnapshot()
    }

}

extension DDSViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            NSLog("\(selectedItems.map { data[$0.item] })")
        }
    }
}
