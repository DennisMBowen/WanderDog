//
//  FindDogFriendlyEstablishments.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/31/26.
//

import Foundation

import Foundation

struct ResponseData: Codable {
    let return_data: [DogFriendlyEstablishment]
}

struct DogFriendlyEstablishment: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
}

enum RequestError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

func callFindDogFriendlyEstablishmentsMicroservice(radius: Int, startingLatitude: Double, startingLongitude: Double) -> [DogFriendlyEstablishment] {
    
    var dogEstablishments: [DogFriendlyEstablishment] = []
    
    Task {
        do {
            print("Radius \(radius)")
            dogEstablishments = try await findDogFriendlyEstablishments(
                radius: radius,
                startingLatitude: startingLatitude,
                startingLongitude: startingLongitude)
        } catch RequestError.invalidURL {
            print("Invalid URL")
        } catch RequestError.invalidResponse {
            print("Invalid response")
        } catch RequestError.invalidData {
            print("Invalid data")
        } catch {
            print("Errors encountered: \(error)")
        }
    }
    
    return dogEstablishments
    
}

func findDogFriendlyEstablishments(radius: Int, startingLatitude: Double, startingLongitude: Double) async throws -> [DogFriendlyEstablishment] {
    
    let endpoint = "http://classwork.engr.oregonstate.edu:60052/find-dog-friendly-establishments?latitude=\(startingLatitude)&longitude=\(startingLongitude)&radius=\(radius)"
    
    guard let url = URL(string: endpoint) else {
        throw RequestError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw RequestError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let results = try decoder.decode(ResponseData.self, from: data)
        print(results)
        return results.return_data
    } catch {
        throw RequestError.invalidData
    }
}
