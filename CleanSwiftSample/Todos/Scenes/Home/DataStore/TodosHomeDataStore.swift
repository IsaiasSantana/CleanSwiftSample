import Foundation

protocol TodosHomeDataStoreProtocol: AnyObject {
    var todos: [TodoHome.Todo] { get set }
}

final class TodosHomesDataStore: TodosHomeDataStoreProtocol {
    var todos: [TodoHome.Todo] = []
}
