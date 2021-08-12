import Foundation

struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
}

struct ArticleModel: Codable {
    let source: SourceModel
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let url: String?
}

struct SourceModel: Codable {
    let id: String?
    let name: String?
}
