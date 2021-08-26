import Foundation
import UIKit

protocol TodoHomeCoordinatorProtocol: AnyObject {
    func handle(_ route: Route, animated: Bool)
    func openCreateTodoScreen()
    func showTodoDetails(todo: TodoHome.Todo)
}

final class TodoHomeCoordinator: TodoHomeCoordinatorProtocol {
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    func handle(_ route: Route, animated: Bool) {
        guard router.rootViewController != nil else {
            return
        }

        router.route(to: route, animated: animated)
    }

    func openCreateTodoScreen() {
        handle(CreateTodoRoute(), animated: true)
    }

    func showTodoDetails(todo: TodoHome.Todo) {
        let route = TodoDetailsRoute(todo: todo)
        handle(route, animated: true)
    }
}
