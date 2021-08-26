import Foundation
import UIKit

enum TodoDetailsInitializer {
    static func createScene(transition: Transition, todo: TodoHome.Todo) -> UIViewController {
        let persistence = TodosPersistence()
        let dao = TodosDAO(todosPersistence: persistence)
        let dataProvider = TodosDataProvider(todosDAO: dao)
        let router = DefaultRouter(rootTransition: transition)
        let coordinator = TodoDetailsCoordinator(router: router)
        let presenter = TodoDetailsPresenter()
        let dataStore = TodoDetailsDataStore(todo: todo)
        let interactor = TodoDetailsInteractor(coordinator: coordinator,
                                               dataProvider: dataProvider,
                                               dataStore: dataStore,
                                               presenter: presenter)
        let customView = TodoDetailsView()
        let viewController = TodoDetailsViewController(sceneTitle: "Todo details",
                                                       customView: customView,
                                                       interactor: interactor)

        presenter.delegate = viewController
        let navController = UINavigationController(rootViewController: viewController)
        router.rootViewController = navController

        return navController
    }
}
