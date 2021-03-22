//
//  API.swift
//  BaatoApp
//
//  Created by Bhawak Pokhrel on 6/19/20.
//  Copyright © 2020 Bhawak Pokhrel. All rights reserved.
//

import Foundation
import Alamofire
import os.log
public enum NavigationMode {
    case car, bike, foot
}
// error enum
public enum BaatoError: Error {
     case emptyResponse
     case parseError
 }
public class API {
    var base: String = "https://api.baato.io"
    var root: String!
    var search: String!
    var reverse: String!
    var places: String!
    var directions: String!
    var mapstyle: String!
    var token: String!
    fileprivate var requestParameters = [String: Any]()

    // For search
    var query: String?
    var type: String?
    var radius: Int?
    var lat: Double?
    var lon: Double?
    var limit: Int?

    // For place
    var place: Int?

    // For Direction
    var sLat: Double?
    var sLon: Double?
    var dLat: Double?
    var dLon: Double?
    var mode: NavigationMode?
    var alternatives: Bool?
    var instructions: Bool?

//    static let shared = API()
//    public var initAPI: (baseURL: String?, token: String) {
//        get {
//            return (root, token)
//        }
//        set(newBase) {
//            let resourcePath = Bundle.main.path(forResource: "API", ofType: "plist")!
//            let paths = NSDictionary(contentsOfFile: resourcePath)
//            if let api = newBase.0 {
//                root = api
//            } else {
//                root = base + (paths!["root"] as! String)
//            }
//            self.token = newBase.1
//            self.search = root + (paths!["search"] as! String)
//            self.reverse = root + (paths!["reverse"] as! String)
//            self.places = root + (paths!["places"] as! String)
//            self.directions = root + (paths!["directions"] as! String)
//            self.mapstyle = root + (paths!["mapstyle"] as! String)
//        }
//    }
    public init(baseURL: String?, token: String) {
        self.base = "https://api.baato.io"
        if let api = baseURL {
            self.root = api
        } else {
            self.root = base + "/api/v1"
        }
        self.token = token
        self.search = root + "/search"
        self.reverse = root + "/reverse"
        self.places = root + "/places"
        self.directions = root + "/directions"
        self.mapstyle = root + "/styles"
    }
    public init(token: String) {
//        let resourcePath = Bundle.main.path(forResource: "API", ofType: "plist")!
//        let paths = NSDictionary(contentsOfFile: resourcePath)
        self.base = "https://api.baato.io"
        self.root = base + "/api/v1"
        self.token = token
        self.search = root + "/search"
        self.reverse = root + "/reverse"
        self.places = root + "/places"
        self.directions = root + "/directions"
        self.mapstyle = root + "/styles"
    }
    public var searchQuery: String {
        get {
            return query ?? ""
        } set(query) {
            self.query = query
        }
    }
    public var searchType: String {
        get {
            return type ?? ""
        } set(type) {
            self.type = type
        }
    }
    public var searchRadius: Int {
        get {
            return radius ?? 0
        } set(radius) {
            self.radius = radius
        }
    }
    public var searchLimit: Int {
        get {
            return limit ?? 0
        } set(limit) {
            self.limit = limit
        }
    }
    public var searchLat: Double {
        get {
            return lat ?? 0.00
        } set(lat) {
            self.lat = lat
        }
    }
    public var searchLon : Double {
        get {
            return lon ?? 0.00
        } set(lon) {
            self.lon = lon
        }
    }

    public var reverseLat: Double {
        get {
            return lat ?? 0.00
        } set(lat) {
            self.lat = lat
        }
    }
    public var reverseLon : Double {
        get {
            return lon ?? 0.00
        } set(lon) {
            self.lon = lon
        }
    }
    public var placeID: Int {
        get {
            return place ?? 0
        } set(place) {
            self.place = place
        }
    }

     public var startLat: Double {
           get {
               return sLat ?? 0.00
           } set(lat) {
               self.sLat = lat
           }
       }
       public var startLon : Double {
           get {
               return sLon ?? 0.00
           } set(lon) {
               self.sLon = lon
           }
       }
    public var destLat: Double {
           get {
            return dLat ?? 0.00
           } set(lat) {
               self.dLat = lat
           }
       }
       public var destLon : Double {
           get {
               return dLon ?? 0.00
           } set(lon) {
               self.dLon = lon
           }
       }
    public var navMode: NavigationMode {
        get {
            return mode ?? NavigationMode.car
        } set(mode) {
            self.mode = mode
        }
    }
    public var navAlternatives: Bool {
        get {
            return alternatives ?? false
        } set(alternatives){
            self.alternatives = alternatives
        }
    }
    public var navInstructions: Bool {
        get {
            return instructions ?? false
        } set(instructions){
            self.instructions = instructions
        }
    }
    init() {
        self.base = "https://api.baato.io"
        self.root = base + "/api/v1"
        self.search = root + "/search"
        self.reverse = root + "/reverse"
        self.places = root + "/places"
        self.directions = root + "/directions"
        self.mapstyle = root + "/styles"
    }
    fileprivate func freshInitialize()-> Void {
        requestParameters.removeAll()
         //compulsory ones
         guard let token = token else {
            if #available(iOS 10.0, *) {
                os_log("Error request %@%@: %@", log: OSLog.default, type: .error, "Invalid request", "Baato API", "Token Not Found")
            } else {
                print("Token Not Found");
                // Fallback on earlier versions
            }
             return
         }
        requestParameters["key"] = token
    }
    fileprivate func mapQuerySearch()-> Void {
        //Required
       freshInitialize()
        guard let query = query else {
            if #available(iOS 10.0, *) {
                os_log("Error request %@%@: %@", log: OSLog.default, type: .error, "Invalid request", "Search Query", "No Query Parameters")
            } else {
                print("No Query Parameters");
            }
            return
        }
       requestParameters["q"] = query

        //optionals
        if let type = type {
            requestParameters["type"] = type
        }
        if let radius = radius {
            requestParameters["radius"] = radius
        }
        if let limit = limit {
            requestParameters["limit"] = limit
        }
        if let lat = lat {
            requestParameters["lat"] = lat
        }
        if let lon = lon {
            requestParameters["lon"] = lon
        }
    }
    fileprivate func mapQueryReverse()-> Void {
        //Required
        freshInitialize()
        guard let lat = lat else {
            if #available(iOS 10.0, *) {
                os_log("Error request %@%@: %@", log: OSLog.default, type: .error, "Invalid request", "Reverse Query", "Latitide is required")
            } else {
                print("Latitide is required");
                // Fallback on earlier versions
            }
            return
        }
        guard let lon = lon else {
            if #available(iOS 10.0, *) {
                os_log("Error request %@%@: %@", log: OSLog.default, type: .error, "Invalid request", "Reverse Query", "Longitude is required")
            } else {
                print("Longitude is required");
                // Fallback on earlier versions
            }
            return
        }

        requestParameters["lat"] = lat
        requestParameters["lon"] = lon


         //optionals
        if let radius = radius {
            requestParameters["radius"] = radius
        }
    }
    fileprivate func mapQueryPlace()-> Void {
        //Required
        freshInitialize()

        guard let place = place else {
            if #available(iOS 10.0, *) {
                os_log("Error request %@%@: %@", log: OSLog.default, type: .error, "Invalid request", "Place Query", "Place ID is required")
            } else {
                print("Place ID is required");
                // Fallback on earlier versions
            }
            return
        }
        requestParameters["placeId"] = place
    }
    fileprivate func mapQueryDirections()-> Void {
        //Required
        freshInitialize()
        guard let sLat = sLat, let sLon = sLon, let dLat = dLat, let dLon = dLon else {
            if #available(iOS 10.0, *) {
                os_log("Error request %@%@: %@", log: OSLog.default, type: .error, "Invalid request", "Route Query", "Start and End Coordinates are required")
            } else {
                print("Start and End Coordinates are required");
                // Fallback on earlier versions
            }
            return
        }
        let points: [String] = ["\(sLat)," + "\(sLon)", "\(dLat)," + "\(dLon)"]
        requestParameters["points"] = points
        if let mode = mode {
            requestParameters["mode"] = mode
        } else {
            requestParameters["mode"] = NavigationMode.car
        }
        if let alternatives = alternatives {
            requestParameters["alternatives"] = alternatives
        } else {
            requestParameters["alternatives"] = false
        }
        if let instructions = instructions {
            requestParameters["instructions"] = instructions
        } else {
            requestParameters["alternatives"] = false
        }
         //optionals
    }
    fileprivate func mapboxQueryDirections()-> Void {
        //Required
        freshInitialize()
        guard let sLat = sLat, let sLon = sLon, let dLat = dLat, let dLon = dLon else {
            if #available(iOS 10.0, *) {
                os_log("Error request %@%@: %@", log: OSLog.default, type: .error, "Invalid request", "Route Query", "Start and End Coordinates are required")
            } else {
                print("Start and End Coordinates are required");
                // Fallback on earlier versions
            }
            return
        }
        let points: [String] = ["\(sLat)," + "\(sLon)", "\(dLat)," + "\(dLon)"]
        requestParameters["points"] = points
        if let mode = mode {
            requestParameters["mode"] = mode
        } else {
            requestParameters["mode"] = NavigationMode.car
        }
        if let alternatives = alternatives {
            requestParameters["alternatives"] = alternatives
        } else {
            requestParameters["alternatives"] = false
        }
        if let instructions = instructions {
            requestParameters["instructions"] = instructions
        } else {
            requestParameters["instructions"] = false
        }
        requestParameters["forMapbox"] = true
        requestParameters["locale"] = "en_US"
         //optionals
    }
}
extension API {
    public func getSearch(completion: @escaping(Result<[SearchResult]?>) -> Void) {
        mapQuerySearch()
        let searchFilter = requestParameters
        let request = Alamofire.request(search!, method: .get, parameters: searchFilter)
        request.validate(statusCode: 200..<300)
        request.validate(contentType: ["application/json"])
        request.responseJSON { response in
            var searchResult: [SearchResult]?
            switch response.result {
            case .success:
                guard let data = response.data, let value = try? JSONDecoder().decode(ResponseType.self, from: data) else {
                    completion(.failure(BaatoError.emptyResponse))
                    return
                }
                while !value.data.isAtEnd {
                    do {
                        if searchResult == nil {
                            searchResult = [SearchResult]()
                        }
                        let searchData = try value.data.decode(SearchResult.self)
                        searchResult!.append(searchData)
                    } catch {
                        completion(.failure(BaatoError.parseError))
                        self.reportErrorFetching("Search", reason: "could not deserialize")
                    }
                }
                completion(.success(searchResult))
//                completion(searchResult)
            case .failure:
                completion(.failure(response.error!))
                if #available(iOS 10.0, *) {
                    os_log("[Refresh Request] Request failed", log: OSLog.default, type: .error)
                } else {
                    print("[Refresh Request] Request failed");
                    // Fallback on earlier versions
                }
            }
        }
    }
    public func getReverse(completion: @escaping(Result<Place?>) -> Void) {
            mapQueryReverse()
            let filter = requestParameters
            let request = Alamofire.request(reverse!, method: .get, parameters: filter)
            request.validate(statusCode: 200..<300)
            request.validate(contentType: ["application/json"])
            request.responseJSON { response in
                var place: Place?
                switch response.result {
                case .success:
                    guard let data = response.data, let value = try? JSONDecoder().decode(ResponseType.self, from: data) else {
                        completion(.failure(BaatoError.emptyResponse))
                        if #available(iOS 10.0, *) {
                            os_log("[Refresh Request] Error parsing JSON", log: OSLog.default, type: .error)
                        } else {
                            print("[Refresh Request] Error parsing JSON");
                            // Fallback on earlier versions
                        }
                        return
                    }
                        do {
                            place = try value.data.decode(Place.self)
                            completion(.success(place))
                        } catch {
                            completion(.failure(BaatoError.parseError))
                            self.reportErrorFetching("Reverse", reason: "could not deserialize")
                        }
                case .failure:
                    completion(.failure(response.error!))
                    if #available(iOS 10.0, *) {
                        os_log("[Refresh Request] Request failed", log: OSLog.default, type: .error)
                    } else {
                        print("[Refresh Request] Request failed");
                        // Fallback on earlier versions
                    }
                }
            }

    }
    public func getPlaces(completion: @escaping(Result<Place?>) -> Void) {
        mapQueryPlace()
        let filter = requestParameters
        let request = Alamofire.request(places!, method: .get, parameters: filter)
        request.validate(statusCode: 200..<300)
        request.validate(contentType: ["application/json"])
        request.responseJSON { response in
            var place: Place?
            switch response.result {
            case .success:
                guard let data = response.data, let value = try? JSONDecoder().decode(ResponseType.self, from: data) else {
                    completion(.failure(BaatoError.emptyResponse))
                    if #available(iOS 10.0, *) {
                        os_log("[Refresh Request] Error parsing JSON", log: OSLog.default, type: .error)
                    } else {
                        print("[Refresh Request] Error parsing JSON");
                        // Fallback on earlier versions
                    }
                    return
                }
                    do {
                        place = try value.data.decode(Place.self)
                        completion(.success(place))
                    } catch {
                        completion(.failure(BaatoError.parseError))
                        self.reportErrorFetching("Place", reason: "could not deserialize")
//                        return
                    }

            case .failure:
                completion(.failure(response.error!))
                if #available(iOS 10.0, *) {
                    os_log("[Refresh Request] Request failed", log: OSLog.default, type: .error)
                } else {
                    print("[Refresh Request] Request failed");
                    // Fallback on earlier versions
                }
            }
        }
    }
    public func getDirections(completion: @escaping(Result<[NavResponse]?>) -> Void) {
    mapQueryDirections()
    let filter = requestParameters
    let request = Alamofire.request(directions!, method: .get, parameters: filter)
            request.validate(statusCode: 200..<300)
            request.validate(contentType: ["application/json"])
            request.responseJSON { response in
               var navResponse: [NavResponse]?
                switch response.result {
                case .success:
                    guard let data = response.data, let value = try? JSONDecoder().decode(ResponseType.self, from: data) else {
                        completion(.failure(BaatoError.emptyResponse))
                        if #available(iOS 10.0, *) {
                            os_log("[Refresh Request] Error parsing JSON", log: OSLog.default, type: .error)
                        } else {
                            print("[Refresh Request] Error parsing JSON");
                            // Fallback on earlier versions
                        }
                        return
                    }
                    while !value.data.isAtEnd {
                        do {
                            if navResponse == nil {
                                navResponse = [NavResponse]()
                            }
                            let navData = try value.data.decode(NavResponse.self)
                            navResponse!.append(navData)
                        } catch {
                            completion(.failure(BaatoError.parseError))
                            self.reportErrorFetching("Navigation", reason: "could not deserialize")
                        }
                    }
                    completion(.success(navResponse))

                case .failure:
                    completion(.failure(response.error!))
                    if #available(iOS 10.0, *) {
                        os_log("[Refresh Request] Request failed", log: OSLog.default, type: .error)
                    } else {
                        print("[Refresh Request] Request failed");
                        // Fallback on earlier versions
                    }
                }
            }
    }
    public func getMapboxDirections(completion: @escaping(Result<Data?>) -> Void) {
        mapboxQueryDirections()
    let filter = requestParameters
    let request = Alamofire.request(directions!, method: .get, parameters: filter)
            request.validate(statusCode: 200..<300)
            request.validate(contentType: ["application/json"])
            request.responseJSON { response in
                switch response.result {
                case .success:

                    guard let data = response.data else {
                        completion(.failure(BaatoError.parseError))
                        if #available(iOS 10.0, *) {
                            os_log("[Refresh Request] Error parsing JSON", log: OSLog.default, type: .error)
                        } else {
                            print("[Refresh Request] Error parsing JSON");
                            // Fallback on earlier versions
                        }
                        return
                    }
                    completion(.success(data))

                case .failure:
                    completion(.failure(response.error!))
                    if #available(iOS 10.0, *) {
                        os_log("[Refresh Request] Request failed", log: OSLog.default, type: .error)
                    } else {
                        print("[Refresh Request] Request failed");
                        // Fallback on earlier versions
                    }
                }
            }
    }

    public func getmapstyle(){
    }
    fileprivate func reportErrorFetching(_ type: String, identifier: Int? = nil, reason: String) {
        if #available(iOS 10.0, *) {
            os_log("Error fetching %@%@: %@", log: OSLog.default, type: .error, type, identifier != nil ? " \(identifier!)" : "", reason)
        } else {
            print("Error fetching data");
            // Fallback on earlier versions
        }
    }
}
