import Foundation
import UIKit

protocol Route {
    var transition: Transition { get set }
    func createScene() -> UIViewController
}
