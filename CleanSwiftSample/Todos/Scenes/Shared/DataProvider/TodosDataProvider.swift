import Foundation

protocol TodosDataProviderProtocol: AnyObject {
    func addTodo(_ todo: TodoHome.Todo)
    func removeTodo(_ todo: TodoHome.Todo)
    func getAllTodos(result: @escaping(([TodoHome.Todo]) -> Void))
    func removeAllTodos()
}

final class TodosDataProvider: TodosDataProviderProtocol {
    private let todosDAO: TodosDAOProtocol

    init(todosDAO: TodosDAOProtocol) {
        self.todosDAO = todosDAO
    }

    func addTodo(_ todo: TodoHome.Todo) {
        todosDAO.save(todo: todo)
    }

    func removeTodo(_ todo: TodoHome.Todo) {
        todosDAO.delete(todo: todo)
    }

    func getAllTodos(result: @escaping (([TodoHome.Todo]) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            let todos = self.todosDAO.getAllTodos()
            DispatchQueue.main.async { [weak self] in
                guard self != nil else {
                    return
                }
                result(todos)
            }
        }
    }

    func removeAllTodos() {
        todosDAO.getAllTodos().forEach { removeTodo($0) }
    }
}
