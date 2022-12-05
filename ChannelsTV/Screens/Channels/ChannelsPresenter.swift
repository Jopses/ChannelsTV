import Foundation

final class ChannelsPresenter: PropsProducer {
    typealias Props = ChannelsViewController.Props
    
    var propsRelay: Observable<Props> = Observable(.default)

    // MARK: - Properties

	private let router: ChannelsRouterInternal
    private let interactor: ChannelsInteractorProtocol
    private let errorHandler: ErrorHandler
    
    private let userDataService = UserDataService()
    
    private var favorites: [Int]
    private var searchText: String? = nil {
        didSet {
            updateChannelsData()
        }
    }
    private var selectedSegment: Int = 0 {
        didSet {
            updateChannelsData()
        }
    }
    private var channelModel: [ChannelModel] = [] {
        didSet {
            updateChannelsData()
        }
    }

    // MARK: - Lifecycle

    init(router: ChannelsRouterInternal, interactor: ChannelsInteractorProtocol, errorHandler: ErrorHandler) {
        self.router = router
        self.interactor = interactor
        self.errorHandler = errorHandler
        
        self.favorites = userDataService.getData(key: .favoriteChannels) ?? []
        
        propsRelay.value = propsRelay.mutate {
            $0.onSearch = CommandWith<String> { [weak self] text in
                self?.searchText = text.isEmpty ? nil : text
            }
            $0.onNeedRefresh = Command { [weak self] in
                self?.loadChannelsList()
            }
            $0.tabs = TabsSegmentItem.allCases.map {
                TabsSegmentCellViewModel(
                    props: TabsSegmentCell.Props(
                        tab: TabsSegmentModel(
                            id: $0.rawValue,
                            title: $0.title,
                            textColor: $0.textColor,
                            selectedTextColor: $0.selectedTextColor,
                            underlineColor: $0.underlineColor
                        )
                    )
                )
            }
            $0.onTabSegment = CommandWith<Int> { [weak self] segmentIndex in
                self?.selectedSegment = segmentIndex
            }
        }
        
        loadChannelsList()
    }
    
    // MARK: - Private Methods

    private func loadChannelsList() {
        interactor.getChannels { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response: data):
                do {
                    let channelsList = try JSONDecoder().decode(ChannelsListResponse.self, from: data)
                    self.channelModel = channelsList.channels.map { channel in
                        ChannelModel(
                            id: channel.id,
                            name: channel.name,
                            image: channel.image,
                            currentProgramm: channel.title,
                            url: channel.url,
                            isFavorite: self.favorites.contains(where: { $0 == channel.id })
                        )
                    }
                } catch {
                    self.errorHandler.handle(error: NetworkErrors.failedToParseResponse)
                }
            case let .failure(error: error):
                self.errorHandler.handle(error: error)
            }
        }
    }

    private func updateChannelsData() {
        let data = channelModel.filter {
            TabsSegmentItem(rawValue: selectedSegment) == .favorite ? $0.isFavorite : true
        }.filter {
            searchText != nil ? $0.name.lowercased().contains((searchText ?? "").lowercased()) : true
        }
        propsRelay.value = self.propsRelay.mutate {
            $0.items = self.mapChannelCell(data)
        }
    }
    
    private func mapChannelCell(_ data: [ChannelModel]) -> [ChannelCellViewModel] {
        data.map {
            ChannelCellViewModel(
                props: ChannelCell.Props(
                    channel: $0,
                    onClick: CommandWith<ChannelModel> { [weak self] channel in
                        self?.router.runChannelScreen(channel)
                    },
                    onFavorite: CommandWith<ChannelModel> { [weak self] channel in
                        guard let self = self else { return }
                        if channel.isFavorite {
                            guard let index = self.favorites.firstIndex(where: { $0 == channel.id })
                            else { return }
                            self.favorites.remove(at: index)
                        } else {
                            self.favorites.append(channel.id)
                        }
                        self.channelModel = self.channelModel.map {
                            if $0.id == channel.id {
                                var newChannel = $0
                                newChannel.isFavorite = !newChannel.isFavorite
                                return newChannel
                            }
                            return $0
                        }
                        self.userDataService.setData(self.favorites, key: .favoriteChannels)
                    }
                )
            )
        }
    }
}
