import Foundation

protocol CreateTodoInteractorProtocol: AnyObject {
    func createTodo(todoName: String?, todoDescription: String?)
}

final class CreateTodoInteractor: CreateTodoInteractorProtocol {
    private let coordinator: CreateTodoCoordinatorProtocol
    private let dataProvider: TodosDataProviderProtocol
    private let dataStore: CreateTodoDataStoreProtocol
    private let presenter: CreateTodoPresenterProtocol

    init(coordinator: CreateTodoCoordinatorProtocol,
         dataProvider: TodosDataProviderProtocol,
         dataStore: CreateTodoDataStoreProtocol,
         presenter: CreateTodoPresenterProtocol) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.dataStore = dataStore
        self.presenter = presenter
    }

    func createTodo(todoName: String?, todoDescription: String?) {
        guard let todoName = todoName,
              let todoDescription = todoDescription,
              todoName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false,
              todoDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            return
        }
        let todo = buildTodo(todoName: todoName, todoDescription: todoDescription)
        dataProvider.addTodo(todo)
        coordinator.close()
    }

    private func buildTodo(todoName: String, todoDescription: String) -> TodoHome.Todo {
        .init(name: todoName, description: todoDescription)
    }
}
