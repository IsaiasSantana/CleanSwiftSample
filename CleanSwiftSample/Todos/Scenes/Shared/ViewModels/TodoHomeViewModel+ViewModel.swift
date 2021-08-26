import Foundation

extension TodoHomeViewModel {
    struct ViewModel: Equatable {
        let id: String
        let todoName: String
        let todoDescription: String
        let completed: Bool

        static func ==(lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.id == rhs.id
        }
    }
}
