//
//  ChannelCell.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import UIKit

final class ChannelCell: PreparableTableCell {
    // MARK: - Properties
    
    private let channelContentView = with(UIView()) {
        $0.apply([.primaryVariantColor, .corner(10.0)])
    }

    private let channelImage = with(PrepareImageView(image: nil)) {
        $0.apply(.corner(4.0))
    }

    private let channelNameLabel = with(UILabel()) {
        $0.apply([.subtitle1, .onPrimaryColor, .line(1)])
    }

    private let channelProgrammLabel = with(UILabel()) {
        $0.apply([.body1, .onSurfaceColor, .line(1)])
    }
    
    private let favoriteButton = with(UIButton()) {
        $0.setImage(UIImage(named: "star-off"), for: .normal)
        $0.setImage(UIImage(named: "star-on"), for: .selected)
    }

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
        guard let model = viewModel as? ChannelCellViewModel else {
            return
        }
        self.props = model.props
    }

    // MARK: - Prepare View

    private func prepareView() {
        selectionStyle = .none
        contentView.apply(.backgroundColor)
        contentView.addSubview(channelContentView)
        channelContentView.addSubviews(channelImage, channelNameLabel, channelProgrammLabel, favoriteButton)

        makeConstraints()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickAction))
        addGestureRecognizer(gesture)
        favoriteButton.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
    }

    private func makeConstraints() {
        
        channelContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Grid.xs.offset),
            channelContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            channelContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Grid.s.offset),
            channelContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Grid.s.offset)
        ])

        channelImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelImage.heightAnchor.constraint(equalToConstant: 60.0),
            channelImage.widthAnchor.constraint(equalToConstant: 60.0),
            channelImage.topAnchor.constraint(equalTo: channelContentView.topAnchor, constant: Grid.xs.offset),
            channelImage.bottomAnchor.constraint(equalTo: channelContentView.bottomAnchor, constant: -Grid.xs.offset),
            channelImage.leadingAnchor.constraint(equalTo: channelContentView.leadingAnchor, constant: Grid.xs.offset)
        ])
        
        channelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelNameLabel.topAnchor.constraint(equalTo: channelContentView.topAnchor, constant: 14.0),
            channelNameLabel.leadingAnchor.constraint(equalTo: channelImage.trailingAnchor, constant: Grid.s.offset)
        ])
        
        channelProgrammLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelProgrammLabel.topAnchor.constraint(equalTo: channelNameLabel.bottomAnchor, constant: Grid.xs.offset),
            channelProgrammLabel.bottomAnchor.constraint(equalTo: channelContentView.bottomAnchor, constant: -14.0),
            channelProgrammLabel.leadingAnchor.constraint(equalTo: channelNameLabel.leadingAnchor),
            channelProgrammLabel.trailingAnchor.constraint(equalTo: channelNameLabel.trailingAnchor)
        ])
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: channelContentView.topAnchor, constant: Grid.xs.offset),
            favoriteButton.bottomAnchor.constraint(equalTo: channelContentView.bottomAnchor, constant: -Grid.xs.offset),
            favoriteButton.leadingAnchor.constraint(equalTo: channelNameLabel.trailingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: channelContentView.trailingAnchor, constant: -Grid.xs.offset),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
    }

    // MARK: - Render

    private func render(oldProps: Props, newProps: Props) {
        if oldProps.channel != newProps.channel, let channel = newProps.channel {
            channelImage.setImage(urlString: channel.image)
            channelNameLabel.text = channel.name
            channelProgrammLabel.text = channel.currentProgramm
            favoriteButton.isSelected = channel.isFavorite
        }
    }

    // MARK: - Actions

    @objc private func clickAction() {
        guard let channel = props.channel else { return }
        props.onClick.execute(with: channel)
    }

    @objc private func favoriteAction() {
        guard let channel = props.channel else { return }
        props.onFavorite.execute(with: channel)
    }
}


// MARK: - Props

extension ChannelCell {
    struct Props: Mutable, Hashable {
        var channel: ChannelModel?
        var onClick: CommandWith<ChannelModel>
        var onFavorite: CommandWith<ChannelModel>

        static let `default` = Props(channel: nil, onClick: .empty, onFavorite: .empty)

        static func == (lhs: Props, rhs: Props) -> Bool {
            lhs.channel == rhs.channel
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(channel?.id)
        }
    }
}
