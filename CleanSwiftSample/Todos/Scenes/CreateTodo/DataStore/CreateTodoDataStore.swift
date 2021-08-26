import Foundation

protocol CreateTodoDataStoreProtocol: AnyObject {
    var todoName: String? { get set }
    var todoDescription: String? { get set }
}

final class CreateTodoDataStore: CreateTodoDataStoreProtocol {
    var todoName: String?
    var todoDescription: String?
}
