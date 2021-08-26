import Foundation

protocol TodosPersistenceProtocol {
    func addTodo(data: Data, id: String)
    func getTodo(id: String) -> Data?
    func removeTodo(id: String)
    func getAllTodos() -> [Data]
}

final class TodosPersistence: TodosPersistenceProtocol {
    private let todosId = "TODOS_HOME_TODOS_LIST_IDS"
    private var ids: [String] {
        get {
            UserDefaults.standard.value(forKey: todosId) as? [String] ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: todosId)
        }
    }

    func addTodo(data: Data, id: String)  {
        UserDefaults.standard.setValue(data, forKey: id)
        addIdIfDontExist(id)
    }

    private func addIdIfDontExist(_ id: String) {
        guard ids.contains(id) == false else {
            return
        }
        ids.append(id)
    }

    func getTodo(id: String) -> Data? {
        UserDefaults.standard.data(forKey: id)
    }

    func removeTodo(id: String)  {
        UserDefaults.standard.removeObject(forKey: id)
        ids.removeAll { $0 == id }
    }

    func getAllTodos() -> [Data] {
        var result = [Data]()
        for id in ids {
            if let data = getTodo(id: id) {
                result.append(data)
            }
        }
        return result
    }
}
