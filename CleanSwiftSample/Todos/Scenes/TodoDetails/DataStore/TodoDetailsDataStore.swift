import Foundation

protocol TodoDetailsDataStoreProtocol: AnyObject {
    var todo: TodoHome.Todo { get }
}

final class TodoDetailsDataStore: TodoDetailsDataStoreProtocol {
    let todo: TodoHome.Todo

    init(todo: TodoHome.Todo) {
        self.todo = todo
    }
}
