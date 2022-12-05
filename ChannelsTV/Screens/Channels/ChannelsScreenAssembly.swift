import UIKit

final class ChannelsScreenAssembly {

    func assemble() -> UIViewController {

        let router = ChannelsRouter()
        let network = NetworkClientService()
        let interactor = ChannelsInteractor(networkClientService: network)
        let errorHandler = ErrorHandler()
        let presenter = ChannelsPresenter(router: router, interactor: interactor, errorHandler: errorHandler)
        let tableAdapter = ChannelsTableAdapter()
        let view = ChannelsViewController(tableAdapter: tableAdapter)
        view.bind(to: presenter)
        router.view = view
        errorHandler.messagesView = view

        return view
    }
}
