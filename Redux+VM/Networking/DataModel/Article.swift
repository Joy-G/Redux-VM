// This file was generated from JSON Schema using quicktype, do not modify it directly.

import Foundation

// MARK: - Welcome
public struct News: Codable {
    public let status, source, sortBy: String?
    public let articles: [Article]?
}

// MARK: Welcome convenience initializers and mutators

public extension News {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(News.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        status: String?? = nil,
        source: String?? = nil,
        sortBy: String?? = nil,
        articles: [Article]?? = nil
    ) -> News {
        return News(
            status: status ?? self.status,
            source: source ?? self.source,
            sortBy: sortBy ?? self.sortBy,
            articles: articles ?? self.articles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Article
public struct Article: Codable {
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt
    }
}

// MARK: Article convenience initializers and mutators

public extension Article {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Article.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        author: String?? = nil,
        title: String?? = nil,
        articleDescription: String?? = nil,
        url: String?? = nil,
        urlToImage: String?? = nil,
        publishedAt: Date?? = nil
    ) -> Article {
        return Article(
            author: author ?? self.author,
            title: title ?? self.title,
            articleDescription: articleDescription ?? self.articleDescription,
            url: url ?? self.url,
            urlToImage: urlToImage ?? self.urlToImage,
            publishedAt: publishedAt ?? self.publishedAt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
