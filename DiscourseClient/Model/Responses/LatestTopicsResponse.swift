import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    var topicList: TopicList
    
    enum CodingKeys: String, CodingKey {
        case topicList = "topic_list"
    }
}

struct TopicList: Codable {
    var topics: [Topic]
}

struct Topic: Codable {
    var id: Int
    var title: String
    var closed: Bool
}
