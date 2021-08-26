import Foundation

protocol TodoDetailsInteractorProtocol: AnyObject {
    func viewDidLoad()
    func didTouchDeleteTodo()
    func didTouchCloseButton()
}

final class TodoDetailsInteractor: TodoDetailsInteractorProtocol {
    private let coordinator: TodoDetailsCoordinatorProtocol
    private let dataProvider: TodosDataProviderProtocol
    private let dataStore: TodoDetailsDataStoreProtocol
    private let presenter: TodoDetailsPresenterProtocol

    init(coordinator: TodoDetailsCoordinatorProtocol,
         dataProvider: TodosDataProviderProtocol,
         dataStore: TodoDetailsDataStoreProtocol,
         presenter: TodoDetailsPresenterProtocol) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.dataStore = dataStore
        self.presenter = presenter
    }

    func viewDidLoad() {
        presenter.present(todo: dataStore.todo)
    }

    func didTouchDeleteTodo() {
        dataProvider.removeTodo(dataStore.todo)
        coordinator.close()
    }

    func didTouchCloseButton() {
        coordinator.close()
    }
}
