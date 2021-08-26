import Foundation
import UIKit

// This is a adaptation of https://github.com/CassiusPacheco/iOS-Routing-Example/blob/master/RoutingExample/Routing/Router.swift

protocol Routable: AnyObject {
    func route(to route: Route, animated: Bool, completion: (() -> Void)?)
    func route(to route: Route, animated: Bool)
}
