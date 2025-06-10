//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

struct Post: Hashable, Codable {
    let id: String
    let title: String
    let views: Int
}

class PostsViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    private let tableView = UITableView()
    private var dataSource: DataSource!
    
    private let titleTextField = UITextField()
    private let viewsTextField = UITextField()
    
    private let addButton = UIButton()
    private let loadingView = UIActivityIndicatorView()
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Post>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Post>
    
    private var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
        configureDataSource()
        fetchPosts()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        
        titleTextField.placeholder = "title"
        titleTextField.borderStyle = .roundedRect
        
        viewsTextField.placeholder = "views"
        viewsTextField.borderStyle = .roundedRect
        
        addButton.configuration = .filled()
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubviews(titleTextField, viewsTextField, addButton, tableView, loadingView)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        viewsTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(viewsTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalTo(tableView.snp.center)
        }
        
    }
    
    func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
            cell.configure(title: item.title, views: item.views)
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    @objc func addTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, let views = viewsTextField.text, !title.isEmpty, !views.isEmpty else { return }
        let newPost = Post(id: UUID().uuidString, title: title, views: Int(views) ?? .zero)
        Task {
            do {
                let isSuccess = try await networkManager.addPost(newPost)
                if isSuccess {
                    posts.append(newPost)
                    applySnapshot()
                }
            }
        }
    }
    
    func fetchPosts() {
        showLoadingView()
        Task {
            do {
                let posts = try await networkManager.getPosts()
                self.posts = posts ?? []
                applySnapshot()
                hideLoadingView()
            }
        }
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    func hideLoadingView() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }

}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            Task {
                do {
                    let post = self.posts[indexPath.row]
                    let isSuccess = try await self.networkManager.deletePost(post)
                    if isSuccess {
                        self.posts.remove(at: indexPath.row)
                        self.applySnapshot()
                    }
                }
            }
            completion(true)
        }
        
        let resetAction = UIContextualAction(style: .normal, title: "Reset") { _, _, completion in
            Task {
                do {
                    let post = self.posts[indexPath.row]
                    if let post = try await self.networkManager.updatePost(post) {
                        self.posts.remove(at: indexPath.row)
                        self.posts.insert(post, at: indexPath.row)
                        self.applySnapshot()
                    }
                }
            }
            completion(true)
        }
        
        resetAction.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [deleteAction, resetAction])
    }
}

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    
    private let titleLabel = UILabel()
    private let viewsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        viewsLabel.font = .systemFont(ofSize: 16)
        viewsLabel.textColor = .systemGray
        
        contentView.addSubviews(titleLabel, viewsLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        viewsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(title: String, views: Int) {
        titleLabel.text = title
        viewsLabel.text = "\(views) views"
    }
}
