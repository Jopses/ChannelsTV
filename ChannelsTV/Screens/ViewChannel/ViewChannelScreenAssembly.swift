import UIKit

final class ViewChannelScreenAssembly {

    func assemble(channel: ChannelModel) -> UIViewController {

        let router = ViewChannelRouter()
        let presenter = ViewChannelPresenter(router: router, channel: channel)
        let view = ViewChannelViewController()
        view.bind(to: presenter)
        router.view = view

        return view
    }
}
