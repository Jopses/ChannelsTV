import UIKit

final class ChannelsTableAdapter: NSObject {

    // MARK: - Properties
    
    private enum Section: Hashable {
        case main
    }

    var items: [ChannelCellViewModel] = [] {
        didSet {
            updateSnapshot()
        }
    }
    
    private var diffableDataSource: UITableViewDiffableDataSource<Section, ChannelCellViewModel>?
    
    func makeDiffableDataSource(_ table: UITableView) {
        diffableDataSource = UITableViewDiffableDataSource<Section, ChannelCellViewModel>(tableView: table) {
            tableView, indexPath, viewModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellId, for: indexPath)
            if let reusableCell = cell as? PreparableTableCell {
                reusableCell.prepare(withViewModel: viewModel)
            }
            return cell
        }
        updateSnapshot()
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChannelCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        diffableDataSource?.apply(snapshot, animatingDifferences: false)
    }

}
