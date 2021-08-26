import Foundation
import UIKit

struct TodoDetailsRoute: Route {
    var transition: Transition = ModalTransition(modalPresentationStyle: .fullScreen)
    private let todo: TodoHome.Todo
    
    init(todo: TodoHome.Todo) {
        self.todo = todo
    }

    func createScene() -> UIViewController {
        TodoDetailsInitializer.createScene(transition: transition, todo: todo)
    }
}
