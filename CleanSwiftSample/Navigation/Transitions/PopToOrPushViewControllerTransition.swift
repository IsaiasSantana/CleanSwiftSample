import Foundation
import UIKit

final class PopToOrPushViewControllerTransition: NSObject {
    private weak var from: UIViewController?
    private var openCompletionHandler: (() -> Void)?
    private var closeCompletionHandler: (() -> Void)?

    private var navigationController: UINavigationController? {
        guard let navigation = from as? UINavigationController else {
            return from?.navigationController
        }
        return navigation
    }
}

extension PopToOrPushViewControllerTransition: Transition {
    func open(_ viewController: UIViewController, from: UIViewController, animated: Bool, completion: (() -> Void)?) {
       self.from = from
        openCompletionHandler = completion
        navigationController?.delegate = self
        if let viewControllers = navigationController?.viewControllers {
            if viewControllers.contains(where: {type(of: $0) == type(of: viewController)}) {
                                
                var newViewControllers = viewControllers
                
                while !newViewControllers.isEmpty && type(of: newViewControllers[newViewControllers.count - 1]) != type(of: viewController) {
                    newViewControllers.removeLast()
                }
                
                if newViewControllers.isEmpty {
                    newViewControllers = viewControllers + [viewController]
                } else {
                    newViewControllers.removeLast()
                    newViewControllers = newViewControllers + [viewController]
                }
    
                navigationController?.viewControllers = newViewControllers
            } else {
                navigationController?.pushViewController(viewController, animated: animated)
            }
        } else {
            navigationController?.pushViewController(viewController, animated: animated)
        }
        
    }

    func close(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController?.popViewController(animated: animated)
    }
}

extension PopToOrPushViewControllerTransition: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let transitionCoordinator = navigationController.transitionCoordinator,
            let fromVC = transitionCoordinator.viewController(forKey: .from),
            let toVC = transitionCoordinator.viewController(forKey: .to) else {
            return
        }

        if fromVC == from {
            openCompletionHandler?()
            openCompletionHandler = nil
        } else if toVC == from {
            closeCompletionHandler?()
            closeCompletionHandler = nil
        }
    }
}
