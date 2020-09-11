//
//  ResponseType.swift
//  BaatoApp
//
//  Created by Bhawak Pokhrel on 6/23/20.
//  Copyright © 2020 Bhawak Pokhrel. All rights reserved.
//   let welcome = try? newJSONDecoder().decode(ResponseType.self, from: jsonData)

import Foundation

// MARK: - Welcome
public class ResponseType: NSObject, NSCoding, Codable {
    let timestamp: String
    let status: Int
    let message: String
    var data: UnkeyedDecodingContainer

    // coding keys for Decodable
    enum CodingKeys: String, CodingKey {
        case timestamp
        case status
        case message
        case data
    }
        // computed properties
        var currentPage: UnkeyedDecodingContainer {
            return data
        }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(timestamp, forKey: .timestamp)
            try container.encode(status, forKey: .status)
            try container.encode(message, forKey: .message)
        }

        // MARK: Decodable

    required public init(from decoder: Decoder) throws {
            // get container
            let container = try decoder.container(keyedBy: CodingKeys.self)

            // get properties
            timestamp = try container.decode(String.self, forKey: .timestamp)
            status = try container.decode(Int.self, forKey: .status)
            message = try container.decode(String.self, forKey: .message)
            data = try container.nestedUnkeyedContainer(forKey: .data)
        }

    public func encode(with aCoder: NSCoder) {
            aCoder.encode(timestamp, forKey: CodingKeys.timestamp.rawValue)
            aCoder.encode(status, forKey: CodingKeys.status.rawValue)
            aCoder.encode(message, forKey: CodingKeys.message.rawValue)
            aCoder.encode(data, forKey: CodingKeys.data.rawValue)
        }
        init(timestamp: String, status: Int, message: String, data: UnkeyedDecodingContainer) {
            self.timestamp = timestamp
            self.status = status
            self.message = message
            self.data = data
        }

    required  public init?(coder aDecoder: NSCoder) {
            timestamp = aDecoder.decodeObject(forKey: CodingKeys.timestamp.rawValue) as! String
            status = aDecoder.decodeInteger(forKey: CodingKeys.status.rawValue)
            message = aDecoder.decodeObject(forKey: CodingKeys.message.rawValue) as! String
            data = (aDecoder.decodeObject(forKey: CodingKeys.data.rawValue) as! UnkeyedDecodingContainer)
        }

}
