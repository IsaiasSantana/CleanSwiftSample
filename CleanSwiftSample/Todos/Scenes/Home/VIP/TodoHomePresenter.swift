import Foundation

protocol TodoHomePresenterProtocol: AnyObject {
    func present(todos: [TodoHome.Todo])
    func presentEmptyState()
}

protocol TodoHomePresenterDelegate: AnyObject {
    func render(todos: [TodoHomeViewModel.ViewModel])
    func renderEmptyState(withMessage message: String)
}

// Todo: Implement unit tests
final class TodoHomePresenter: TodoHomePresenterProtocol {
    weak var delegate: TodoHomePresenterDelegate?

    func present(todos: [TodoHome.Todo]) {
        delegate?.render(todos: viewModel(from: todos))
    }

    private func viewModel(from todos: [TodoHome.Todo]) -> [TodoHomeViewModel.ViewModel] {
        todos.map { viewModel(from: $0) }
    }

    private func viewModel(from todo: TodoHome.Todo) -> TodoHomeViewModel.ViewModel {
        .init(id: todo.id,
              todoName: todo.name,
              todoDescription: todo.description,
              completed: todo.completed)
    }

    func presentEmptyState() {
        delegate?.renderEmptyState(withMessage: TodoHomeStrings.emptyTodos)
    }
}
