import UIKit

protocol ChannelsRouterInternal: AnyObject {
    func runChannelScreen(_ channel: ChannelModel)
}

final class ChannelsRouter {

	// MARK: - Properties

    weak var view: ScreenTransitionable?
}

// MARK: - ChannelsRouterInternal

extension ChannelsRouter: ChannelsRouterInternal {
    func runChannelScreen(_ channel: ChannelModel) {
        let screen = ViewChannelScreenAssembly().assemble(channel: channel)
        screen.modalPresentationStyle = .fullScreen
        view?.presentScreen(screen, animated: true, completion: nil)
    }
}
