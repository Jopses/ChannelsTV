//
//  TabsSegmentCell.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

class TabsSegmentCell: PreparableCollectionCell {
    // MARK: - Properties

    private let titleLabel = with(UILabel()) {
        $0.apply([.button, .line(1), .alignCenter])
    }

    private let titleUnderline = with(UIView()) {
        $0.backgroundColor = .clear
    }

    var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    override var isSelected: Bool {
        didSet {
            setColorTitle()
            titleUnderline.isHidden = !isSelected
        }
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        props = .default
    }
    
    override func prepare(withViewModel viewModel: PreparableViewModel?) {
        guard let model = viewModel as? TabsSegmentCellViewModel else {
            return
        }
        self.props = model.props
    }

    // MARK: - Prepare View

    private func prepareViews() {
        titleUnderline.isHidden = true
        contentView.addSubviews(titleLabel, titleUnderline)
        setConstraints()
    }

    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0)
        ])
        
        titleUnderline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleUnderline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleUnderline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleUnderline.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Grid.s.offset),
            titleUnderline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6.0),
            titleUnderline.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }

    // MARK: - Private Method

    private func setColorTitle() {
        guard let tab = props.tab else { return }
        titleLabel.textColor = isSelected ? tab.selectedTextColor : tab.textColor
    }

    // MARK: - Render

    private func render(oldProps: Props, newProps: Props) {
        if oldProps.tab != newProps.tab, let tab = newProps.tab {
            titleLabel.text = tab.title
            titleUnderline.backgroundColor = tab.selectedTextColor
            titleUnderline.backgroundColor = tab.underlineColor
            setColorTitle()
        }
    }
}

// MARK: - Props

extension TabsSegmentCell {
    struct Props: Mutable, Equatable {
        var tab: TabsSegmentModel?

        static let `default` = Props(tab: nil)
        
        static func == (lhs: Props, rhs: Props) -> Bool {
            lhs.tab == rhs.tab
        }
    }
}
