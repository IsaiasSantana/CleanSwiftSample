import Foundation
import UIKit

extension UITableView {
    func dequeue<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.cellIdentifier, for: indexPath) as? Cell else {
            fatalError("Cannot create instace of cell with identifier: \(Cell.cellIdentifier)")
        }

        return cell
    }

    func register<Cell: UITableViewCell>(_: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.cellIdentifier)
    }
}
