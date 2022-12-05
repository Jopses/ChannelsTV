//
//  ContextMenuController.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

struct ContextMenuSize {
    static let tableViewWidth: CGFloat = 128.0
    static let padding: CGFloat = 0.0
    static let itemHeight: CGFloat = 40.0
    static let itemSpacing: CGFloat = 0.5
}

enum ContextMenuPosition {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

final class ContextMenuController: UIViewController {
    // MARK: - Properties
    
    private lazy var tableView = with(UITableView()) {
        $0.apply(.context)
        $0.register(ContextMenuCell.self, forCellReuseIdentifier: ContextMenuCell.className)
        $0.dataSource = self
        $0.delegate = self
    }
    
    private var tableViewHeight: CGFloat = 0.0
    private var contextMenuCells: [ContextMenuCellViewModel] = []

    var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        var sizes: [CGFloat] = []
        props.items.forEach { item in
            sizes.append(item.calcWidth(maxSize: CGSize(width: .infinity, height: ContextMenuSize.itemHeight),
                                              font: UIFont.systemFont(ofSize: 17.0, weight: .regular)))
        }
        
        let width = max(ContextMenuSize.tableViewWidth, (sizes.max(by: <) ?? 0) + 76)
        
        guard let position = calculatePosition(width: width) else { return }
        
        tableView.frame = CGRect(
            x: position.x,
            y: position.y,
            width: width,
            height: tableViewHeight
        )

    }
    
    // MARK: - Prepare View
    
    private func prepareView() {
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = .clear
        view.isOpaque = false
        
        view.addSubview(tableView)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideAction))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: - Private Methods

    private func calculatePosition(width: CGFloat) -> CGPoint? {
        guard let view = props.viewTarget else { return nil }

        let nowPosition: CGPoint = view.convert(view.bounds.origin, to: self.view)
        let nowSize: CGSize = view.frame.size

        switch props.position {
        case .topLeft:
            return CGPoint(
                x: nowPosition.x + nowSize.width - width,
                y: nowPosition.y - ContextMenuSize.padding - tableViewHeight
            )
        case .topRight:
            return CGPoint(
                x: nowPosition.x,
                y: nowPosition.y - ContextMenuSize.padding - tableViewHeight
            )
        case .bottomLeft:
            return CGPoint(
                x: nowPosition.x + nowSize.width - width,
                y: nowPosition.y + nowSize.height + ContextMenuSize.padding
            )
        case .bottomRight:
            return CGPoint(
                x: nowPosition.x,
                y: nowPosition.y + nowSize.height + ContextMenuSize.padding
            )
        }
    }

    private func render(oldProps: Props, newProps: Props) {
        if oldProps.items != newProps.items {
            contextMenuCells = newProps.items.map {
                ContextMenuCellViewModel(props: ContextMenuCell.Props(title: $0))
            }
            tableView.reloadData()

            let countItem: CGFloat = CGFloat(newProps.items.count)
            tableViewHeight = (countItem * ContextMenuSize.itemHeight)
            viewWillLayoutSubviews()
            tableView.selectRow(at: IndexPath(item: newProps.selectedIndex, section: 0),
                                animated: false,
                                scrollPosition: .none)
        }
    }
    
    // MARK: - Actions
    
    @objc func hideAction() {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - Props

extension ContextMenuController {
    struct Props: Mutable {
        var items: [String]
        var position: ContextMenuPosition
        weak var viewTarget: UIView?
        var selectedIndex: Int
        var onChange: CommandWith<Int>
        
        public static let `default` = Props(items: [], position: .topLeft, selectedIndex: 0, onChange: .empty)
    }
}

extension ContextMenuController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contextMenuCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = contextMenuCells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellId, for: indexPath)
        if let reusableCell = cell as? PreparableTableCell {
            reusableCell.prepare(withViewModel: model)
        }
        return cell
    }
}

extension ContextMenuController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.onChange.execute(with: indexPath.row)
    }
}

extension ContextMenuController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tableView) == true {
            return false
        }
        return true
    }
}
