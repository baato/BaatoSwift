//
//  NavResponse.swift
//  BaatoApp
//
//  Created by Bhawak Pokhrel on 7/23/20.
//  Copyright © 2020 Bhawak Pokhrel. All rights reserved.
//

import Foundation

public class NavResponse: Codable {
    public let routeWight: Double?
    public let distanceInMeters: Double
    public let encodedPolyline: String
    public let timeInMs: CLong
    public let instructionList: UnkeyedDecodingContainer

    enum CodingKeys: String, CodingKey {
        case routeWeight, distanceInMeters, encodedPolyline, timeInMs, instructionList
    }

    init(routeWight: Double?, distanceInMeters: Double, encodedPolyline: String, timeInMs: CLong, instructionList: UnkeyedDecodingContainer ) {
           self.routeWight = routeWight
           self.distanceInMeters = distanceInMeters
           self.encodedPolyline = encodedPolyline
           self.timeInMs = timeInMs
           self.instructionList = instructionList
       }
    public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(routeWight, forKey: .routeWeight)
        try container.encode(distanceInMeters, forKey: .distanceInMeters)
        try container.encode(encodedPolyline, forKey: .encodedPolyline)
        try container.encode(timeInMs, forKey: .timeInMs)
    }
    // MARK: Decodable

    required public init(from decoder: Decoder) throws {
        // get container
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // get properties
        routeWight = try container.decodeIfPresent(Double.self, forKey: .routeWeight)
        distanceInMeters = try container.decode(Double.self, forKey: .distanceInMeters)
        encodedPolyline = try container.decode(String.self, forKey: .encodedPolyline)
        timeInMs = try container.decode(CLong.self, forKey: .timeInMs)
        instructionList = try container.nestedUnkeyedContainer(forKey: .instructionList)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(routeWight, forKey: CodingKeys.routeWeight.rawValue)
        aCoder.encode(distanceInMeters, forKey: CodingKeys.distanceInMeters.rawValue)
        aCoder.encode(encodedPolyline, forKey: CodingKeys.encodedPolyline.rawValue)
        aCoder.encode(timeInMs, forKey: CodingKeys.timeInMs.rawValue)
        aCoder.encode(instructionList, forKey: CodingKeys.instructionList.rawValue)
    }

}
