//
//  FindRoute.swift
//  WanderDog
//
//  Created by Dennis Bowen on 6/1/26.
//

import Foundation

struct Route: Codable {
    let route_distance_m: Double
    let route_duration_sec: Double
    let polyline: String
    let geometry: geometry
    
}

struct geometry: Codable {
    let type: String
    let coordinates: [[Double]]
}

enum RouteRequestError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

func callFindRouteMicroservice(originLat: Double, originLon: Double, destinationLat: Double, destinationLon: Double) async -> Route {
    
    var errorRoute = Route(route_distance_m: 0, route_duration_sec: 0, polyline: "", geometry: geometry(type: "", coordinates: []))
    let transitOption = "walking"
    let optimizationOption = "distance"

    do {
        let route = try await findRoute(
            originLat: originLat,
            originLon: originLon,
            destinationLat: destinationLat,
            destinationLon: destinationLon,
            transitOption: transitOption,
            optimizationOption: optimizationOption
        )
        return route
    } catch RouteRequestError.invalidURL {
        print("Invalid URL")
    } catch RouteRequestError.invalidResponse {
        print("Invalid response")
    } catch RouteRequestError.invalidData {
        print("Invalid data")
    } catch {
        print("Errors encountered: \(error)")
    }
    
    return errorRoute

}
                
func findRoute(
    originLat: Double,
    originLon: Double,
    destinationLat: Double,
    destinationLon: Double,
    transitOption: String,
    optimizationOption: String
) async throws -> Route {
    
    let endpoint = "http://classwork.engr.oregonstate.edu:45533/find-route?origin_lat=\(originLat)&origin_lon=\(originLon)&destination_lat=\(destinationLat)&destination_lon=\(destinationLon)&transit_mode=\(transitOption)&optimization_mode=\(optimizationOption)"
    
    
    guard let url = URL(string: endpoint) else {
        throw RouteRequestError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw RouteRequestError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let routeResult = try decoder.decode(Route.self, from: data)
        return routeResult
    } catch {
        throw RouteRequestError.invalidData
    }
}


