import Foundation
import UIKit

final class AppConfiguration {
    private var window: UIWindow?
    private lazy var featuresInitializer = FeaturesInitializer()

    func setup(with window: UIWindow?) {
        self.window = window

        let navigationController = UINavigationController()
        navigationController.pushViewController(featuresInitializer.todosFeature.todos().initialScene(),
                                                animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

final class FeaturesInitializer {
    lazy var todosFeature = TodosFeatureInitializer()
}

final class TodosFeatureInitializer {
    func todos() -> TodosFeature {
        TodosFeature()
    }
}
