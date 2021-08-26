import Foundation

protocol TodoDetailsPresenterProtocol: AnyObject {
    func present(todo: TodoHome.Todo)
}

protocol TodoDetailsPresenterDelegate: AnyObject {
    func render(viewModel: TodoDetailsViewModel.ViewModel)
}

final class TodoDetailsPresenter: TodoDetailsPresenterProtocol {
    weak var delegate: TodoDetailsPresenterDelegate?

    func present(todo: TodoHome.Todo) {
        let viewModel = viewModel(from: todo)
        delegate?.render(viewModel: viewModel)
    }

    private func viewModel(from todo: TodoHome.Todo) -> TodoDetailsViewModel.ViewModel {
        .init(todoName: todo.name, todoDescription: todo.description)
    }
}
