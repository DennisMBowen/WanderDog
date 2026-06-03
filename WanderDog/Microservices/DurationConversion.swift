//
//  DurationConversion.swift
//  WanderDog
//
//  Created by Dennis Bowen on 6/2/26.
//

import Foundation

import Foundation

struct DurationConversion: Codable {
    let formatted: String
    let hours: Int
    let minutes: Int
    let seconds: Int
}


enum DurationConversionRequestError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

func callDurationConversionMicroservice(seconds: Int) async -> DurationConversion {
    
    
    let errorConverion = DurationConversion(formatted: "", hours: 0, minutes: 0, seconds: 0)
    
    do {
        let durationConversion = try await convertDuration(seconds: seconds)
        
        return durationConversion

    } catch DurationConversionRequestError.invalidURL {
        print("Invalid URL")
    } catch DurationConversionRequestError.invalidResponse {
        print("Invalid response")
    } catch DurationConversionRequestError.invalidData {
        print("Invalid data")
    } catch {
        print("Errors encountered: \(error)")
    }

    return errorConverion
}

func convertDuration(seconds: Int) async throws -> DurationConversion {
    
    let endpoint = "http://classwork.engr.oregonstate.edu:45541/duration-conversion?seconds=\(seconds)"
    
    guard let url = URL(string: endpoint) else {
        throw DurationConversionRequestError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw DurationConversionRequestError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let results = try decoder.decode(DurationConversion.self, from: data)
        return results
    } catch {
        throw DurationConversionRequestError.invalidData
    }
}
