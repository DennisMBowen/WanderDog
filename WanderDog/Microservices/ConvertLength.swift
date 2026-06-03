//
//  ConvertLength.swift
//  WanderDog
//
//  Created by Dennis Bowen on 6/2/26.
//



import Foundation

struct ConvertLengthData: Codable {
    let units: Double
}


enum ConvertLengthRequestError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

func callConvertLengthMicroservice(measurement: Double, inputType: String, conversionType: String) async -> Double {
    
    var convertedMeasurement: Double = 0.0
    
    do {
        convertedMeasurement = try await convertLengthUnits(
            measurement: measurement,
            inputType: inputType,
            conversionType: conversionType)

    } catch RequestError.invalidURL {
        print("Invalid URL")
    } catch RequestError.invalidResponse {
        print("Invalid response")
    } catch RequestError.invalidData {
        print("Invalid data")
    } catch {
        print("Errors encountered: \(error)")
    }

    return convertedMeasurement
}

func convertLengthUnits(measurement: Double, inputType: String, conversionType: String) async throws -> Double {
    
    let endpoint = "http://classwork.engr.oregonstate.edu:60050/convert-length?measurement=\(measurement)&input_type=\(inputType)&conversion_type=\(conversionType)"
    
    guard let url = URL(string: endpoint) else {
        throw ConvertLengthRequestError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw ConvertLengthRequestError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let results = try decoder.decode(ConvertLengthData.self, from: data)
        return results.units
    } catch {
        throw ConvertLengthRequestError.invalidData
    }
}
