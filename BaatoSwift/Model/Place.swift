//
//  Place.swift
//  BaatoApp
//
//  Created by Bhawak Pokhrel on 6/23/20.
//  Copyright © 2020 Bhawak Pokhrel. All rights reserved.
// let place = try? newJSONDecoder().decode(Place.self, from: jsonData)

import Foundation
import GEOSwift

// MARK: - Datum
public class Place: Codable {
    init(centroid: Centroid) {
        self.centroid = centroid
        self.placeID = nil
        self.license = nil
        self.name = nil
        self.address = nil
        self.type = nil
        self.tags = nil
        self.geometry = nil
        self.score = nil
    }

    public let placeID: Int?
    public let license, name, address, type: String?
    public let centroid: Centroid
    public let tags: [String]?
    public let geometry: Geometry?
    public let score: StringOrIntType?

    enum CodingKeys: String, CodingKey {
        case placeID = "placeId"
        case license, name, address, type, centroid, tags, geometry, score
    }

    init(placeID: Int, license: String, name: String, address: String, type: String, centroid: Centroid, tags: [String], geometry: Geometry, score: StringOrIntType) {
        self.placeID = placeID
        self.license = license
        self.name = name
        self.address = address
        self.type = type
        self.centroid = centroid
        self.tags = tags
        self.geometry = geometry
//        let score : Int? = Int(score) ?? 0
        self.score = score
    }

}

// MARK: - Centroid
public class Centroid: Codable {
    public let lat, lon: Double

    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
public enum StringOrIntType: Codable {
    case string(String)
    case int(Int)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .string(container.decode(String.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .int(container.decode(Int.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(StringOrIntType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}

// MARK: - Geometry
//class Geometry: Codable {
//    let coordinates: AnyObject
//    let type: String
//
//    init(coordinates: AnyObject, type: String) {
//        self.coordinates = coordinates
//        self.type = type
//    }
//}

