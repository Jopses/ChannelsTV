import UIKit

final class ChannelsViewController: UIViewController, ScreenTransitionable, PropsConsumer, UserMessagesView {

    // MARK: - Properties
    
    private let headerContentView = with(UIView()) {
        $0.apply(.primaryColor)
    }
    
    private let searchField = with(UITextField()) {
        $0.apply(.search)
    }

    private let tableView = with(UITableView()) {
        $0.apply(.primary)
        $0.register(ChannelCell.self, forCellReuseIdentifier: ChannelCell.className)
    }
    
    private let refreshControl = with(UIRefreshControl()) {
        $0.apply(.primary)
    }
    
    private let tabsSegmentView = TabsSegmentView()
    
    private let tableAdapter: ChannelsTableAdapter
    
    internal var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    // MARK: - Lifecycle

    init(tableAdapter: ChannelsTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        makeConstraints()
        
        tableAdapter.makeDiffableDataSource(tableView)
        tableView.refreshControl = refreshControl
        
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        refreshControl.addTarget(self, action: #selector(needToRefresh), for: .valueChanged)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Prepare View

    private func prepareView() {
        view.apply(.primaryColor)
        view.addSubviews(headerContentView, tabsSegmentView, tableView)
        headerContentView.addSubviews(searchField)
    }
    
    private func makeConstraints() {
        
        headerContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: headerContentView.topAnchor, constant: Grid.xs.offset),
            searchField.bottomAnchor.constraint(equalTo: headerContentView.bottomAnchor, constant: -Grid.xs.offset),
            searchField.leadingAnchor.constraint(equalTo: headerContentView.leadingAnchor, constant: Grid.sm.offset),
            searchField.trailingAnchor.constraint(equalTo: headerContentView.trailingAnchor, constant: -Grid.sm.offset),
            searchField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
        
        tabsSegmentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabsSegmentView.topAnchor.constraint(equalTo: headerContentView.bottomAnchor),
            tabsSegmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabsSegmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tabsSegmentView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    // MARK: - Render
    private func render(oldProps: Props, newProps: Props) {
        refreshControl.endRefreshing()
        
        if oldProps.items != newProps.items {
            tableAdapter.items = newProps.items
        }
        if oldProps.tabs != newProps.tabs {
            tabsSegmentView.props.tabs = newProps.tabs
            tabsSegmentView.props.onSelect = newProps.onTabSegment
        }
    }

    // MARK: - Actions
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        props.onSearch.execute(with: textField.text ?? "")
    }
    
    @objc private func needToRefresh() {
        props.onNeedRefresh.execute()
    }
}

// MARK: - Props

extension ChannelsViewController {
    struct Props: Mutable, Equatable {
        var items: [ChannelCellViewModel]
        var tabs: [TabsSegmentCellViewModel]
        var onSearch: CommandWith<String>
        var onNeedRefresh: Command
        var onTabSegment: CommandWith<Int>
        
        static var `default` = Props(items: [], tabs: [],
                                     onSearch: .empty, onNeedRefresh: .empty, onTabSegment: .empty)
        
        static func == (lhs: ChannelsViewController.Props, rhs: ChannelsViewController.Props) -> Bool {
            lhs.items == rhs.items && lhs.tabs == rhs.tabs
        }
    }
}

extension ChannelsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        searchField.resignFirstResponder()
        return true
    }
}
