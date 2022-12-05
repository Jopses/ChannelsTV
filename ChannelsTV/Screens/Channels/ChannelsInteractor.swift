
protocol ChannelsInteractorProtocol: AnyObject {
    func getChannels(completion: @escaping NetworkClientService.Callback)
}

final class ChannelsInteractor {

    // MARK: - Properties

    private let networkClientService: NetworkClientService

    // MARK: - Lifecycle

    init(networkClientService: NetworkClientService) {
        self.networkClientService = networkClientService
    }
}

// MARK: - ChannelsInteractorInput

extension ChannelsInteractor: ChannelsInteractorProtocol {
    func getChannels(completion: @escaping NetworkClientService.Callback) {
        networkClientService.request(target: LimeApi.getPlaylist, completion: completion)
    }
}
