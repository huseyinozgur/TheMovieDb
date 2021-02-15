import Foundation
import Alamofire

// MARK: - MovieDetailResponse
class MovieDetailResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(adult: Bool?, backdropPath: String?, belongsToCollection: BelongsToCollection?, budget: Int?, genres: [Genre]?, homepage: String?, id: Int?, imdbID: String?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, productionCompanies: [ProductionCompany]?, productionCountries: [ProductionCountry]?, releaseDate: String?, revenue: Int?, runtime: Int?, spokenLanguages: [SpokenLanguage]?, status: String?, tagline: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

// MARK: MovieDetailResponse convenience initializers and mutators

extension MovieDetailResponse {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MovieDetailResponse.self, from: data)
        self.init(adult: me.adult, backdropPath: me.backdropPath, belongsToCollection: me.belongsToCollection, budget: me.budget, genres: me.genres, homepage: me.homepage, id: me.id, imdbID: me.imdbID, originalLanguage: me.originalLanguage, originalTitle: me.originalTitle, overview: me.overview, popularity: me.popularity, posterPath: me.posterPath, productionCompanies: me.productionCompanies, productionCountries: me.productionCountries, releaseDate: me.releaseDate, revenue: me.revenue, runtime: me.runtime, spokenLanguages: me.spokenLanguages, status: me.status, tagline: me.tagline, title: me.title, video: me.video, voteAverage: me.voteAverage, voteCount: me.voteCount)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        adult: Bool?? = nil,
        backdropPath: String?? = nil,
        belongsToCollection: BelongsToCollection?? = nil,
        budget: Int?? = nil,
        genres: [Genre]?? = nil,
        homepage: String?? = nil,
        id: Int?? = nil,
        imdbID: String?? = nil,
        originalLanguage: String?? = nil,
        originalTitle: String?? = nil,
        overview: String?? = nil,
        popularity: Double?? = nil,
        posterPath: String?? = nil,
        productionCompanies: [ProductionCompany]?? = nil,
        productionCountries: [ProductionCountry]?? = nil,
        releaseDate: String?? = nil,
        revenue: Int?? = nil,
        runtime: Int?? = nil,
        spokenLanguages: [SpokenLanguage]?? = nil,
        status: String?? = nil,
        tagline: String?? = nil,
        title: String?? = nil,
        video: Bool?? = nil,
        voteAverage: Double?? = nil,
        voteCount: Int?? = nil
    ) -> MovieDetailResponse {
        return MovieDetailResponse(
            adult: adult ?? self.adult,
            backdropPath: backdropPath ?? self.backdropPath,
            belongsToCollection: belongsToCollection ?? self.belongsToCollection,
            budget: budget ?? self.budget,
            genres: genres ?? self.genres,
            homepage: homepage ?? self.homepage,
            id: id ?? self.id,
            imdbID: imdbID ?? self.imdbID,
            originalLanguage: originalLanguage ?? self.originalLanguage,
            originalTitle: originalTitle ?? self.originalTitle,
            overview: overview ?? self.overview,
            popularity: popularity ?? self.popularity,
            posterPath: posterPath ?? self.posterPath,
            productionCompanies: productionCompanies ?? self.productionCompanies,
            productionCountries: productionCountries ?? self.productionCountries,
            releaseDate: releaseDate ?? self.releaseDate,
            revenue: revenue ?? self.revenue,
            runtime: runtime ?? self.runtime,
            spokenLanguages: spokenLanguages ?? self.spokenLanguages,
            status: status ?? self.status,
            tagline: tagline ?? self.tagline,
            title: title ?? self.title,
            video: video ?? self.video,
            voteAverage: voteAverage ?? self.voteAverage,
            voteCount: voteCount ?? self.voteCount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseBelongsToCollection { response in
//     if let belongsToCollection = response.result.value {
//       ...
//     }
//   }

// MARK: - BelongsToCollection
class BelongsToCollection: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    init(id: Int?, name: String?, posterPath: String?, backdropPath: String?) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}

// MARK: BelongsToCollection convenience initializers and mutators

extension BelongsToCollection {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(BelongsToCollection.self, from: data)
        self.init(id: me.id, name: me.name, posterPath: me.posterPath, backdropPath: me.backdropPath)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        name: String?? = nil,
        posterPath: String?? = nil,
        backdropPath: String?? = nil
    ) -> BelongsToCollection {
        return BelongsToCollection(
            id: id ?? self.id,
            name: name ?? self.name,
            posterPath: posterPath ?? self.posterPath,
            backdropPath: backdropPath ?? self.backdropPath
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseGenre { response in
//     if let genre = response.result.value {
//       ...
//     }
//   }

// MARK: - Genre
class Genre: Codable {
    let id: Int?
    let name: String?

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: Genre convenience initializers and mutators

extension Genre {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Genre.self, from: data)
        self.init(id: me.id, name: me.name)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        name: String?? = nil
    ) -> Genre {
        return Genre(
            id: id ?? self.id,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProductionCompany { response in
//     if let productionCompany = response.result.value {
//       ...
//     }
//   }

// MARK: - ProductionCompany
class ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }

    init(id: Int?, logoPath: String?, name: String?, originCountry: String?) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}

// MARK: ProductionCompany convenience initializers and mutators

extension ProductionCompany {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ProductionCompany.self, from: data)
        self.init(id: me.id, logoPath: me.logoPath, name: me.name, originCountry: me.originCountry)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        logoPath: String?? = nil,
        name: String?? = nil,
        originCountry: String?? = nil
    ) -> ProductionCompany {
        return ProductionCompany(
            id: id ?? self.id,
            logoPath: logoPath ?? self.logoPath,
            name: name ?? self.name,
            originCountry: originCountry ?? self.originCountry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProductionCountry { response in
//     if let productionCountry = response.result.value {
//       ...
//     }
//   }

// MARK: - ProductionCountry
class ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }

    init(iso3166_1: String?, name: String?) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
}

// MARK: ProductionCountry convenience initializers and mutators

extension ProductionCountry {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ProductionCountry.self, from: data)
        self.init(iso3166_1: me.iso3166_1, name: me.name)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        iso3166_1: String?? = nil,
        name: String?? = nil
    ) -> ProductionCountry {
        return ProductionCountry(
            iso3166_1: iso3166_1 ?? self.iso3166_1,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSpokenLanguage { response in
//     if let spokenLanguage = response.result.value {
//       ...
//     }
//   }

// MARK: - SpokenLanguage
class SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }

    init(englishName: String?, iso639_1: String?, name: String?) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }
}

// MARK: SpokenLanguage convenience initializers and mutators

extension SpokenLanguage {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SpokenLanguage.self, from: data)
        self.init(englishName: me.englishName, iso639_1: me.iso639_1, name: me.name)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        englishName: String?? = nil,
        iso639_1: String?? = nil,
        name: String?? = nil
    ) -> SpokenLanguage {
        return SpokenLanguage(
            englishName: englishName ?? self.englishName,
            iso639_1: iso639_1 ?? self.iso639_1,
            name: name ?? self.name
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

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func responseMovieDetailResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<MovieDetailResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
