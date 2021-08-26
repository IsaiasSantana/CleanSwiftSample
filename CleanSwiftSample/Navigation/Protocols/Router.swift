import Foundation
import UIKit

protocol Router: Routable {
    var rootViewController: UIViewController? { get set }
}
