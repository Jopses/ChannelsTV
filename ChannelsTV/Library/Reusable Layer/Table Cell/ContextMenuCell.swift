//
//  ContextMenuCell.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

final class ContextMenuCell: PreparableTableCell {
    // MARK: - Properties

    var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func prepare(withViewModel viewModel: PreparableViewModel?) {
        guard let model = viewModel as? ContextMenuCellViewModel else {
            return
        }
        self.props = model.props
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        setStyleCell(selected)
    }

    // MARK: - Prepare View

    private func prepareView() {
        selectionStyle = .default
        contentView.apply(.onPrimaryColor)
        textLabel?.apply([.header6, .alignCenter])
    }

    private func setStyleCell(_ isSelected: Bool) {
        contentView.apply(isSelected ? .secondaryVariantColor : .onPrimaryColor)
        textLabel?.apply(isSelected ? .onPrimaryColor : .onBackgroundColor)
    }

    // MARK: - Render

    private func render(oldProps: Props, newProps: Props) {
        if oldProps.title != newProps.title {
            textLabel?.text = newProps.title
        }
    }
}


// MARK: - Props

extension ContextMenuCell {
    struct Props: Mutable {
        var title: String

        static let `default` = Props(title: "")

        static func == (lhs: Props, rhs: Props) -> Bool {
            lhs.title == rhs.title
        }
    }
}
