import Foundation
import UIKit

final class TodosFeature: Feature {
    func initialScene() -> UIViewController {
        TodosHomeInitializer.createScene(transition: PushTransition())
    }
}
