import Foundation

extension TodoHome {
    struct Todo: Codable {
        private enum CodingKeys: CodingKey {
            case id, name, description, completed
        }

        let id: String
        let name: String
        let description: String
        let completed: Bool

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            description = try container.decode(String.self, forKey: .description)
            completed = try container.decode(Bool.self, forKey: .completed)
        }

        init(id: String = UUID().uuidString,
             name: String,
             description: String,
             completed: Bool = false) {
            self.id = id
            self.name = name
            self.description = description
            self.completed = completed
        }

        func copyWith(name: String? = nil,
                      description: String? = nil,
                      completed: Bool? = nil) -> Todo {

            .init(id: id, name: name ?? self.name,
                  description: description ?? self.description,
                  completed: completed ?? self.completed)
        }
    }
}
