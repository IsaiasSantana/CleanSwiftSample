import Foundation

protocol IdentifiableCell {
    static var cellIdentifier: String { get }
}

extension IdentifiableCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
