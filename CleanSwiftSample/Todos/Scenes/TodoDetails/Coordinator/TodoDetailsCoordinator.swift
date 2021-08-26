import Foundation
import UIKit

protocol TodoDetailsCoordinatorProtocol: AnyObject {
    func handle(_ route: Route, animated: Bool)
    func close()
}

final class TodoDetailsCoordinator: TodoDetailsCoordinatorProtocol {
    private let router: Router & Dismissable

    init(router: Router & Dismissable) {
        self.router = router
    }

    func handle(_ route: Route, animated: Bool) {
        guard router.rootViewController != nil else {
            return
        }
        router.route(to: route, animated: animated)
    }

    func close() {
        router.dismiss(animated: true)
    }
}
