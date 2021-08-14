import Foundation

struct NewsModel: Codable, Equatable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
}

struct ArticleModel: Codable, Equatable {
    let source: SourceModel
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let url: String?
}

struct SourceModel: Codable, Equatable {
    let id: String?
    let name: String?
}
