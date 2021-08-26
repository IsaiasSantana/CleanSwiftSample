import Foundation
import UIKit

struct TodoHomeRoute: Route {
    var transition: Transition = PopToOrPushViewControllerTransition()

    func createScene() -> UIViewController {
        TodosHomeInitializer.createScene(transition: transition)
    }
}
