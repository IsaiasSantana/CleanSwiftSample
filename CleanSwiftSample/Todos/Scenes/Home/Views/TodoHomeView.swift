import Foundation
import UIKit

protocol TodoHomeViewProtocol where Self: UIView {
    func setup(delegate: TodoHomeViewDelegate)
    func render(todos: [TodoHomeViewModel.ViewModel])
    func renderEmptyState(_ message: String)
}

protocol TodoHomeViewDelegate: AnyObject {
    func didSelectTodo(at index: Int)
    func didTouchCheckBox(todoId: String)
}

// Todo: Implement unit tests
final class TodoHomeView: UIView, TodoHomeViewProtocol {
    private let todosTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.register(TodoCell.self)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let errorView = ErrorView()

    private var todos = [TodoHomeViewModel.ViewModel]()

    private weak var delegate: TodoHomeViewDelegate?

    init() {
        super.init(frame: .zero)

        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        setupTableView()
        setupErrorView()
    }

    private func setupTableView() {
        addSubview(todosTableView)
        NSLayoutConstraint.activate([
            todosTableView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            todosTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            todosTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            todosTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupErrorView() {
        addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        errorView.isHidden = true
    }

    func setup(delegate: TodoHomeViewDelegate) {
        self.delegate = delegate
        todosTableView.delegate = self
        todosTableView.dataSource = self
    }

    func render(todos: [TodoHomeViewModel.ViewModel]) {
        self.todos = todos
        errorView.isHidden = true
        todosTableView.reloadData()
    }

    func renderEmptyState(_ message: String) {
        errorView.show(error: message)
        errorView.isHidden = false
    }
}

extension TodoHomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectTodo(at: indexPath.row)
    }
}

extension TodoHomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TodoCell = tableView.dequeue(for: indexPath)

        cell.render(viewModel: todos[indexPath.row])
        cell.delegate = self

        return cell
    }
    
}

extension TodoHomeView: TodoCellDelegate {
    func didTouchCheckBox(todoId: String) {
        delegate?.didTouchCheckBox(todoId: todoId)
    }
}
