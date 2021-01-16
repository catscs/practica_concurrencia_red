import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    var id: Int
    var title: String
    var postsCount: Int
    var details: Details?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case postsCount = "posts_count"
        case details
    }
}

struct Details: Codable {
    var canEdit: Bool?

    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
    }
}
