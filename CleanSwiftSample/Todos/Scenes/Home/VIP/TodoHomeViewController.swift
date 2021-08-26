import Foundation
import UIKit

// Todo: Implement unit tests
final class TodoHomeViewController: UIViewController {
    private let customView: TodoHomeViewProtocol
    private let interactor: TodoHomeInteractorProtocol

    init(sceneTitle: String, interactor: TodoHomeInteractorProtocol, customView: TodoHomeViewProtocol) {
        self.interactor = interactor
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        title = sceneTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("🗑 Deallocating \(String(describing: self))")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCreateTodoButton()
    }

    private func setupCreateTodoButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTouchCreateTodo))
    }

    @objc private func didTouchCreateTodo() {
        interactor.didTouchCreateTodo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        interactor.fetchTodos()
    }
}

extension TodoHomeViewController: TodoHomePresenterDelegate {
    func render(todos: [TodoHomeViewModel.ViewModel]) {
        customView.render(todos: todos)
    }

    func renderEmptyState(withMessage message: String) {
        customView.renderEmptyState(message)
    }
}

extension TodoHomeViewController: TodoHomeViewDelegate {
    func didSelectTodo(at index: Int) {
        interactor.didSelectTodo(at: index)
    }

    func didTouchCheckBox(todoId: String) {
        interactor.didTouchCheckBox(todoId: todoId)
    }
}
