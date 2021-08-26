import Foundation
import UIKit

struct CreateTodoRoute: Route {
    var transition: Transition = PushTransition()

    func createScene() -> UIViewController {
        CreateTodoInitializer.createScene(transition: transition)
    }
}
