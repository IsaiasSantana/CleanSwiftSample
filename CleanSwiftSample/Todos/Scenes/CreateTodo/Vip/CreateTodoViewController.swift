import Foundation
import UIKit

final class CreateTodoViewController: UIViewController {
    private let customView: CreateTodoViewProtocol
    private let interactor: CreateTodoInteractorProtocol

    init(sceneTitle: String, customView: CreateTodoViewProtocol, interactor: CreateTodoInteractorProtocol) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        title = sceneTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    deinit {
        print("🗑 Deallocating \(String(describing: self))")
    }
}

extension CreateTodoViewController: CreateTodoPresenterDelegate {
    
}

extension CreateTodoViewController: CreateTodoViewDelegate {
    func createTodo(name: String?, description: String?) {
        interactor.createTodo(todoName: name, todoDescription: description)
    }
}
