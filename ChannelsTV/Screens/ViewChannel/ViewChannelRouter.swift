import UIKit

protocol ViewChannelRouterInternal: AnyObject {
    func backScreen()
    func openContextMenu(_ props: ContextMenuController.Props)
}

final class ViewChannelRouter {

    // MARK: - Properties

    weak var view: ScreenTransitionable?
}

// MARK: - ChannelsRouterInternal

extension ViewChannelRouter: ViewChannelRouterInternal {
    func backScreen() {
        view?.dismissView(animated: true, completion: nil)
    }
    
    func openContextMenu(_ props: ContextMenuController.Props) {
        let menu = ContextMenuController()
        menu.props = props
        view?.presentScreen(menu, animated: false, completion: nil)
    }
}
