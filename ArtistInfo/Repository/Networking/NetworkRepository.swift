//
//  NetworkRepository.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 12/02/2024.
//

import Foundation

// Simple class for making web requests

protocol NetworkRepositoryProtocol {
    func makeRequest(with urlRequest: URLRequest) async throws -> Data
}

enum SessionError: LocalizedError {
    case serverError

    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Unable to connect to server. Please check your internet connection and try again"
        }
    }
}

struct NetworkRepository: NetworkRepositoryProtocol {
    private let session: URLSession

    init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }

    func makeRequest(with urlRequest: URLRequest) async throws -> Data {
        let (data, _ ) = try await session.data(for: urlRequest)
        return data
    }
}

