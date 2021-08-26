import Foundation
import UIKit

enum TodosHomeInitializer {
    static func createScene(transition: Transition) -> UIViewController {
        let todosPersistence = TodosPersistence()
        let todosDao = TodosDAO(todosPersistence: todosPersistence)
        let dataProvider = TodosDataProvider(todosDAO: todosDao)
        let dataStore = TodosHomesDataStore()
        let presenter = TodoHomePresenter()
        let router = DefaultRouter(rootTransition: transition)
        let coordinator = TodoHomeCoordinator(router: router)
        let interactor = TodoHomeInteractor(coordinator: coordinator,
                                            dataProvider: dataProvider,
                                            dataStore: dataStore,
                                            presenter: presenter)
        let todoView = TodoHomeView()
        let todoHomeViewController = TodoHomeViewController(sceneTitle: TodoHomeStrings.sceneTitle,
                                                            interactor: interactor,
                                                            customView: todoView)
        
        router.rootViewController = todoHomeViewController
        todoView.setup(delegate: todoHomeViewController)
        presenter.delegate = todoHomeViewController

        return todoHomeViewController
    }
}
