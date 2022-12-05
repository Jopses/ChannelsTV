import UIKit

final class ViewChannelViewController: UIViewController, ScreenTransitionable, PropsConsumer {

    // MARK: - Properties
    
    private let backButton = with(UIButton()) {
        $0.setImage(UIImage(named: "back-arrow"), for: .normal)
    }
    
    private let channelImage = with(PrepareImageView(image: nil)) {
        $0.apply(.corner(8.0))
    }

    private let channelNameLabel = with(UILabel()) {
        $0.apply([.header5, .onPrimaryColor, .line(1)])
    }

    private let channelProgrammLabel = with(UILabel()) {
        $0.apply([.header6, .onSurfaceColor, .line(1)])
    }

    private let settingsButton = with(UIButton()) {
        $0.setImage(UIImage(named: "settings"), for: .normal)
    }

    internal var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        makeConstraints()
        
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
    }
    
    private func prepareView() {
        view.apply(.primaryColor)
        view.addSubviews(backButton, channelImage, channelNameLabel, channelProgrammLabel, settingsButton)
    }
    
    private func makeConstraints() {
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0),
            backButton.heightAnchor.constraint(equalToConstant: 44.0),
            backButton.widthAnchor.constraint(equalToConstant: 44.0)
        ])
        
        channelImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelImage.topAnchor.constraint(equalTo: backButton.topAnchor),
            channelImage.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12.0),
            channelImage.heightAnchor.constraint(equalToConstant: 44.0),
            channelImage.widthAnchor.constraint(equalToConstant: 44.0)
        ])
        
        channelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelNameLabel.topAnchor.constraint(equalTo: channelImage.topAnchor),
            channelNameLabel.leadingAnchor.constraint(equalTo: channelImage.trailingAnchor, constant: Grid.sm.offset),
            channelNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Grid.sm.offset)
        ])
        
        channelProgrammLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelProgrammLabel.topAnchor.constraint(equalTo: channelNameLabel.bottomAnchor),
            channelProgrammLabel.leadingAnchor.constraint(equalTo: channelNameLabel.leadingAnchor),
            channelProgrammLabel.trailingAnchor.constraint(equalTo: channelNameLabel.trailingAnchor)
        ])
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12.0),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12.0),
            settingsButton.heightAnchor.constraint(equalToConstant: 44.0),
            settingsButton.widthAnchor.constraint(equalToConstant: 44.0)
        ])
    }

    // MARK: - Prepare View
    
    // MARK: - Render
    private func render(oldProps: Props, newProps: Props) {
        if oldProps.channel != newProps.channel, let channel = newProps.channel {
            channelImage.setImage(urlString: channel.image)
            channelNameLabel.text = channel.name
            channelProgrammLabel.text = channel.currentProgramm
        }
    }
    
    // MARK: - Actions
    
    @objc private func backAction() {
        props.onBack.execute()
    }

    @objc private func settingAction() {
        props.onSetting.execute(with: settingsButton)
    }
}

// MARK: - Props

extension ViewChannelViewController {
    struct Props: Mutable, Equatable {
        var channel: ChannelModel?
        var onBack: Command
        var onSetting: CommandWith<UIView>
        
        static var `default` = Props(channel: nil, onBack: .empty, onSetting: .empty)
        
        static func == (lhs: Props, rhs: Props) -> Bool {
            lhs.channel == rhs.channel
        }
    }
}
