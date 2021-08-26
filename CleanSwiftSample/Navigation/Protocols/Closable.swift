import Foundation

// Reference: https://cassiuspacheco.com/clean-simple-and-composable-routing-for-ios-apps-ck7qv6kgo0063zns1gdpgwrue

protocol Closable: AnyObject {
    func close(animated: Bool)

    func close(animated: Bool, completion: (() -> Void)?)
}
