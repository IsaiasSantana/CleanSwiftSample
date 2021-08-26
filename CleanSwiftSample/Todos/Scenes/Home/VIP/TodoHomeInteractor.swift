import Foundation

protocol TodoHomeInteractorProtocol: AnyObject {
    func fetchTodos()
    func didSelectTodo(at index: Int)
    func didTouchCreateTodo()
    func didTouchCheckBox(todoId: String)
}

// Todo: Implement unit tests
final class TodoHomeInteractor: TodoHomeInteractorProtocol {
    private let coordinator: TodoHomeCoordinator
    private let dataProvider: TodosDataProviderProtocol
    private let dataStore: TodosHomeDataStoreProtocol
    private let presenter: TodoHomePresenterProtocol

    init(coordinator: TodoHomeCoordinator,
         dataProvider: TodosDataProviderProtocol,
         dataStore: TodosHomeDataStoreProtocol,
         presenter: TodoHomePresenterProtocol) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.dataStore = dataStore
        self.presenter = presenter
    }

    func fetchTodos() {
        dataProvider.getAllTodos { [weak self] todos in
            self?.handleTodos(todos)
        }
    }

    private func handleTodos(_ todos: [TodoHome.Todo]) {
        dataStore.todos = todos
        if todos.isEmpty {
            presenter.presentEmptyState()
        } else {
            presenter.present(todos: todos)
        }
    }

    func didSelectTodo(at index: Int) {
        guard dataStore.todos.isEmpty == false,
              index >= 0,
              index < dataStore.todos.count else {
            return
        }
        coordinator.showTodoDetails(todo: dataStore.todos[index])
    }

    func didTouchCreateTodo() {
        coordinator.openCreateTodoScreen()
    }

    func didTouchCheckBox(todoId: String) {
        guard let selectedTodo = dataStore.todos.first(where: { $0.id == todoId }) else {
            return
        }
        updateCompletedStatus(of: selectedTodo)
    }

    private func updateCompletedStatus(of todo: TodoHome.Todo) {
        let todoUpdated = todo.copyWith(completed: !todo.completed)
        dataProvider.addTodo(todoUpdated)
        fetchTodos()
    }
}
