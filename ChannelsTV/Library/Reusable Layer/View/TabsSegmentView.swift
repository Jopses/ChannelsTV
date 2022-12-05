//
//  TabsSegmentView.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

final class TabsSegmentView: UIView {
    // MARK: - Properties

    private let flowLayout = with(UICollectionViewFlowLayout()) {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 10.0
        $0.sectionInset = .zero
    }
    
    private lazy var collectionView = with(UICollectionView(frame: .zero, collectionViewLayout: flowLayout)) {
        $0.backgroundColor = backgroundColor
        $0.allowsMultipleSelection = true
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        $0.bounces = true
        $0.dataSource = self
        $0.delegate = self
        $0.register(TabsSegmentCell.self, forCellWithReuseIdentifier: TabsSegmentCell.className)
    }
    
    var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    private var selectedSegmentIndex: Int = 0 {
        didSet {
            collectionView.selectItem(
                at: IndexPath(item: selectedSegmentIndex, section: 0),
                animated: false,
                scrollPosition: .centeredHorizontally
            )
            props.onSelect.execute(with: selectedSegmentIndex)
        }
    }

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        prepareViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare View
    
    private func prepareViews() {
        addSubview(collectionView)
        
        makeConstraints()
    }

    private func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Grid.xl.offset)
        ])
    }
    
    // MARK: - Private Method
    

    // MARK: - Render

    private func render(oldProps: Props, newProps: Props) {
        if oldProps.tabs != newProps.tabs {
            collectionView.reloadData()
            collectionView.selectItem(
                at: IndexPath(item: selectedSegmentIndex, section: 0),
                animated: false,
                scrollPosition: .centeredHorizontally
            )
        }
    }
}

// MARK: - Props

extension TabsSegmentView {
    struct Props: Mutable, Equatable {
        var tabs: [TabsSegmentCellViewModel]
        var onSelect: CommandWith<Int>

        static let `default` = Props(tabs: [], onSelect: .empty)
        
        static func == (lhs: Props, rhs: Props) -> Bool {
            lhs.tabs == rhs.tabs
        }
    }
}

// MARK: - UICollectionViewDataSource

extension TabsSegmentView: UICollectionViewDataSource {
    public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return props.tabs.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = props.tabs[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.cellId, for: indexPath)
        if let reusableCell = cell as? PreparableCollectionCell {
            reusableCell.prepare(withViewModel: model)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TabsSegmentView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let selectedIndexPaths = collectionView.indexPathsForSelectedItems ?? []
        if !selectedIndexPaths.contains(indexPath) {
            selectedIndexPaths.forEach { collectionView.deselectItem(at: $0, animated: false) }
            return true
        }
        return false
    }

    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let selectedIndexPaths = collectionView.indexPathsForSelectedItems ?? []
        return !selectedIndexPaths.contains(indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSegmentIndex = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension TabsSegmentView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let calcWidth = ceil(
            (props.tabs[indexPath.row].props.tab?.title ?? "").calcWidth(
                maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
                font: DefaultTypography.button
            )
        )
        return CGSize(width: calcWidth + 28.0, height: height)
    }
}


