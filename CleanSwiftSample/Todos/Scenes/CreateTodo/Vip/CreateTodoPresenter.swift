import Foundation

protocol CreateTodoPresenterProtocol: AnyObject {
    
}

protocol CreateTodoPresenterDelegate: AnyObject {
    
}

final class CreateTodoPresenter: CreateTodoPresenterProtocol {
    weak var delegate: CreateTodoPresenterDelegate?
}
