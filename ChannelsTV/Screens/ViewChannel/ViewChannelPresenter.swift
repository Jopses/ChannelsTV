
import UIKit

final class ViewChannelPresenter: PropsProducer {
    typealias Props = ViewChannelViewController.Props
    
    var propsRelay: Observable<Props> = Observable(.default)
    // MARK: - Properties

	private let router: ViewChannelRouterInternal
    private let channel: ChannelModel
    
    private var settingItems: [String] = ["1080p", "720p", "480p", "360p", "AUTO"]
    private lazy var settingSelectedIndex: Int = settingItems.indices.last ?? 0

    // MARK: - Lifecycle

    init(router: ViewChannelRouterInternal, channel: ChannelModel) {
    	self.router = router
        self.channel = channel
        
        propsRelay.value = propsRelay.mutate {
            $0.channel = channel
            $0.onBack = Command { [weak self] in
                self?.router.backScreen()
            }
            $0.onSetting = CommandWith<UIView> { [weak self] view in
                guard let self = self else { return }
                let props = ContextMenuController.Props(
                    items: self.settingItems,
                    position: .topLeft,
                    viewTarget: view,
                    selectedIndex: self.settingSelectedIndex,
                    onChange: CommandWith<Int> { index in
                        self.settingSelectedIndex = index
                    }
                )
                self.router.openContextMenu(props)
            }
        }
    }
}
