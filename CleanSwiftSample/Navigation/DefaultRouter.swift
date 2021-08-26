import Foundation
import UIKit

final class DefaultRouter: NSObject {
    weak var rootViewController: UIViewController?
    private let rootTransition: Transition

    init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }
}

extension DefaultRouter: Router {
    func route(to route: Route, animated: Bool, completion: (() -> Void)?) {
        guard let rootViewController = rootViewController else {
            return
        }

        route.transition.open(route.createScene(),
                              from: rootViewController,
                              animated: animated,
                              completion: completion)
    }

    func route(to route: Route, animated: Bool) {
        self.route(to: route, animated: animated,completion: nil)
    }
}

extension DefaultRouter: Dismissable {
    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        rootViewController?.dismiss(animated: animated, completion: completion)
    }
}

extension DefaultRouter: Closable {
    func close(animated: Bool) {
        close(animated: animated, completion: nil)
    }

    func close(animated: Bool, completion: (() -> Void)?) {
        guard let rootViewController = rootViewController else {
            return
        }

        rootTransition.close(rootViewController, animated: animated, completion: completion)
    }
}
