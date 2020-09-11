//
//  Search.swift
//  BaatoApp
//
//  Created by Bhawak Pokhrel on 6/21/20.
//  Copyright © 2020 Bhawak Pokhrel. All rights reserved.
//

import Foundation
// MARK: - Datum
public class SearchResult: Codable, Hashable {
    public let placeID: Int
    public let name, address, type: String
    public let score: Double

    enum CodingKeys: String, CodingKey {
        case placeID = "placeId"
        case name, address, type, score
    }

    init(placeID: Int, name: String, address: String, type: String, score: Double) {
        self.placeID = placeID
        self.name = name
        self.address = address
        self.type = type
        self.score = score
    }
    public static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.placeID == rhs.placeID
    }
   public func hash(into hasher: inout Hasher) {
        hasher.combine(placeID)
    }
}
