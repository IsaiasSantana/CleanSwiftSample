import Foundation
import UIKit

protocol CreateTodoCoordinatorProtocol: AnyObject {
    func handle(_ route: Route, animated: Bool)
    func close()
}

final class CreateTodoCoordinator: CreateTodoCoordinatorProtocol {
    private let router: Router & Closable

    init(router: Router & Closable) {
        self.router = router
    }

    func handle(_ route: Route, animated: Bool) {
        guard router.rootViewController != nil else {
            return
        }
        router.route(to: route, animated: true)
    }

    func close() {
       router.close(animated: true)
    }
}
