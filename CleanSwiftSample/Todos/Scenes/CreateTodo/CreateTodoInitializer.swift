import Foundation
import UIKit

enum CreateTodoInitializer {
    static func createScene(transition: Transition) -> UIViewController {
        let todosPersistence = TodosPersistence()
        let todosDAO = TodosDAO(todosPersistence: todosPersistence)
        let todosDataProvider = TodosDataProvider(todosDAO: todosDAO)
        let dataStore = CreateTodoDataStore()
        let presenter = CreateTodoPresenter()
        let router = DefaultRouter(rootTransition: transition)
        let coordinator = CreateTodoCoordinator(router: router)
        let interactor = CreateTodoInteractor(coordinator: coordinator,
                                              dataProvider: todosDataProvider,
                                              dataStore: dataStore,
                                              presenter: presenter)
        let customView = CreateTodoView()
        let viewController = CreateTodoViewController(sceneTitle: CreateTodoStrings.sceneTitle,
                                                      customView: customView,
                                                      interactor: interactor)

        presenter.delegate = viewController
        router.rootViewController = viewController
        customView.setup(delegate: viewController)

        return viewController
    }
}
