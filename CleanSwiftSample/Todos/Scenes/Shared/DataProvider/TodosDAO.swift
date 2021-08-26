import Foundation

protocol TodosDAOProtocol {
    func save(todo: TodoHome.Todo)
    func delete(todo: TodoHome.Todo)
    func getAllTodos() -> [TodoHome.Todo]
}

final class TodosDAO: TodosDAOProtocol {
    private let todosPersistence: TodosPersistenceProtocol

    init(todosPersistence: TodosPersistenceProtocol) {
        self.todosPersistence = todosPersistence
    }

    func save(todo: TodoHome.Todo) {
        guard let data = try? todo.encode() else {
            return
        }
        todosPersistence.addTodo(data: data, id: todo.id)
    }

    func delete(todo: TodoHome.Todo) {
        todosPersistence.removeTodo(id: todo.id)
    }

    func getAllTodos() -> [TodoHome.Todo] {
        return todosPersistence.getAllTodos().compactMap {
            try? JSONDecoder().decode(TodoHome.Todo.self, from: $0)
        }
    }
}

private extension Encodable {
    func encode() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
