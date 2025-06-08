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

    var countries = ["India", "USA", "France", "Japan"]
    var capitals = ["New Delhi", "Washington, D.C.", "Paris", "Tokyo"]
    
    let tableView = UITableView()
    let countryTextField = UITextField()
    let capitalTextField = UITextField()
    let addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func setupUI() {
        title = "Countries and Capitals"
        navigationItem.rightBarButtonItem = editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        countryTextField.borderStyle = .roundedRect
        countryTextField.placeholder = "Country"
        capitalTextField.borderStyle = .roundedRect
        capitalTextField.placeholder = "Capital"
        addButton.setTitle("Add", for: .normal)
        addButton.configuration = .filled()
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        
        view.addSubviews(tableView, countryTextField, capitalTextField, addButton)
        
        countryTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        capitalTextField.snp.makeConstraints { make in
            make.top.equalTo(countryTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(capitalTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func addClicked() {
        guard let country = countryTextField.text, let capital = capitalTextField.text, !country.isEmpty, !capital.isEmpty else { return }
        countries.append(country)
        capitals.append(capital)
        let indexPath = IndexPath(row: countries.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.configure(title: countries[indexPath.row], subtitle: capitals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            countries.remove(at: indexPath.row)
            capitals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemCountry = countries.remove(at: sourceIndexPath.row)
        let itemCapital = capitals.remove(at: sourceIndexPath.row)
        countries.insert(itemCountry, at: destinationIndexPath.row)
        capitals.insert(itemCapital, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.countries.remove(at: indexPath.row)
            self.capitals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { _, _, completion in
            NSLog("Favoruted: \(self.countries[indexPath.row]) - \(self.capitals[indexPath.row])")
            completion(true)
        }
        favoriteAction.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [deleteAction, favoriteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAction = UIContextualAction(style: .normal, title: "Mark") { _, _, completion in
            NSLog("Marked: \(self.countries[indexPath.row]) - \(self.capitals[indexPath.row])")
            completion(true)
        }
        markAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [markAction])
    }
}

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        // Shift content manually if needed
        if editing {
            // Move content to the right
            contentView.frame = contentView.frame.offsetBy(dx: 20, dy: 0)
        } else {
            // Reset content position
            contentView.frame = contentView.frame.offsetBy(dx: -20, dy: 0)
        }
    }
    
    func setupUI() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .systemGray
        
        stackView.addArrangedSubviews([titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}

class SecondViewController: UIViewController {

    let countries = ["India", "USA", "France", "Japan"]
    let capitals = ["New Delhi", "Washington, D.C.", "Paris", "Tokyo"]
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.register(SwiftUICustomCell.self, forCellReuseIdentifier: SwiftUICustomCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}


extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwiftUICustomCell.identifier, for: indexPath) as! SwiftUICustomCell
        cell.configure(title: countries[indexPath.row], subtitle: capitals[indexPath.row])
        return cell
    }
}

struct CustomCellView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.blue)
            Text(subtitle)
                .font(.system(size: 14))
                .foregroundStyle(.gray)
        }
        .padding(16)
    }
}

class SwiftUICustomCell: UITableViewCell {
    
    static let identifier = "SwiftUICustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, subtitle: String) {
        contentConfiguration = UIHostingConfiguration {
            CustomCellView(title: title, subtitle: subtitle)
        }
        .margins(.all, .zero)
    }
    
}

class SectionedViewController: UIViewController {

    var countries = ["India", "USA", "France", "Japan"]
    var capitals = ["New Delhi", "Washington, D.C.", "Paris", "Tokyo"]
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        title = "Countries and Capitals"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.register(SectionedCustomTableViewCell.self, forCellReuseIdentifier: SectionedCustomTableViewCell.identifier)
        
        view.addSubviews(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}


extension SectionedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? countries.count : capitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionedCustomTableViewCell.identifier, for: indexPath) as! SectionedCustomTableViewCell
        let item = indexPath.section == 0 ? countries[indexPath.row] : capitals[indexPath.row]
        cell.configure(title: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Countries" : "Capitals"
    }
}

class SectionedCustomTableViewCell: UITableViewCell {
    
    static let identifier = "SectionedCustomTableViewCell"
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}


class DDSViewController: UIViewController {

    var data: [Item] = [
        Item(country: "India", capital: "New Delhi"),
        Item(country: "USA", capital: "Washington, D.C."),
        Item(country: "France", capital: "Paris"),
        Item(country: "Japan", capital: "Tokyo")
    ]
    
    let tableView = UITableView()
    let countryTextField = UITextField()
    let capitalTextField = UITextField()
    let addButton = UIButton()
    
    enum Section {
        case main
    }
    
    struct Item: Hashable {
        let country: String
        let capital: String
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureDataSource()
        applySnapshot()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: DDSCustomTableViewCell.identifier, for: indexPath) as! DDSCustomTableViewCell
            cell.configure(title: item.country, subtitle: item.capital)
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func setupUI() {
        title = "Countries and Capitals"
        navigationItem.rightBarButtonItem = editButtonItem
        
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.register(DDSCustomTableViewCell.self, forCellReuseIdentifier: DDSCustomTableViewCell.identifier)
        
        countryTextField.borderStyle = .roundedRect
        countryTextField.placeholder = "Country"
        capitalTextField.borderStyle = .roundedRect
        capitalTextField.placeholder = "Capital"
        addButton.setTitle("Add", for: .normal)
        addButton.configuration = .filled()
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        
        view.addSubviews(tableView, countryTextField, capitalTextField, addButton)
        
        countryTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        capitalTextField.snp.makeConstraints { make in
            make.top.equalTo(countryTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(capitalTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func addClicked() {
        guard let country = countryTextField.text, let capital = capitalTextField.text, !country.isEmpty, !capital.isEmpty else { return }
        data.append(Item(country: country, capital: capital))
        self.applySnapshot()
    }
}


extension DDSViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            self.applySnapshot()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.data.remove(at: indexPath.row)
            self.applySnapshot()
            completion(true)
        }
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { _, _, completion in
            NSLog("Favoruted: \(self.data[indexPath.row])")
            completion(true)
        }
        favoriteAction.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [deleteAction, favoriteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAction = UIContextualAction(style: .normal, title: "Mark") { _, _, completion in
            NSLog("Marked: \(self.data[indexPath.row])")
            completion(true)
        }
        markAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [markAction])
    }
}

class DDSCustomTableViewCell: UITableViewCell {
    
    static let identifier = "DDSCustomTableViewCell"
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        // Shift content manually if needed
        if editing {
            // Move content to the right
            contentView.frame = contentView.frame.offsetBy(dx: 20, dy: 0)
        } else {
            // Reset content position
            contentView.frame = contentView.frame.offsetBy(dx: -20, dy: 0)
        }
    }
    
    func setupUI() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .systemGray
        
        stackView.addArrangedSubviews([titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}

class DDSSTableViewCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .systemGray
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(16)
        }
    }
    
    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        accessibilityLabel = "\(title), \(subtitle)"
    }
}

class HeaderView: UITableViewHeaderFooterView {
    static let identifier = "Header"
    let label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        label.text = text
    }
}

enum Section: Hashable {
    case featured
    case regular
}

struct Item: Hashable {
    let id = UUID()
    let title: String
}

typealias DataSource = UITableViewDiffableDataSource<Section, Item>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

class DDSSViewController: UIViewController, UITableViewDelegate {
    let tableView = UITableView()
    var dataSource: DataSource!
    var featuredItems = [Item(title: "Featured 1"), Item(title: "Featured 2")]
    var regularItems = [Item(title: "Regular 1"), Item(title: "Regular 2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureDataSource()
        applySnapshot()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
    }
    
    private func setupTableView() {
        view.backgroundColor = .systemBackground
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
            cell.configure(title: item.title, subtitle: "Details")
            return cell
        }
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.featured, .regular])
        snapshot.appendItems(featuredItems, toSection: .featured)
        snapshot.appendItems(regularItems, toSection: .regular)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    @objc func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.featuredItems = [Item(title: "Refreshed Featured 1"), Item(title: "Refreshed Featured 2")]
            self.regularItems = [Item(title: "Refreshed Regular 1"), Item(title: "Refreshed Regular 2")]
            self.applySnapshot(animatingDifferences: false)
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func toggleEditMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = indexPath.section == 0 ? featuredItems[indexPath.row] : regularItems[indexPath.row]
        print("Selected: \(item.title)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            if indexPath.section == 0 {
                self.featuredItems.remove(at: indexPath.row)
            } else {
                self.regularItems.remove(at: indexPath.row)
            }
            self.applySnapshot()
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                self.featuredItems.remove(at: indexPath.row)
            } else {
                self.regularItems.remove(at: indexPath.row)
            }
            self.applySnapshot()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as! HeaderView
        header.configure(with: section == 0 ? "Featured" : "Regular")
        return header
    }
}
