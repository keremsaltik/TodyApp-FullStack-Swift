//
//  APIError.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case unauthorized
    case requestFailed(description: String)
    case decodingFailed(description: String)
    case serverError(reason: String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL adresi."
        case .unauthorized:
            return "Oturumunuzun süresi dolmuş veya yetkiniz yok."
        case .requestFailed(let description):
            return "İstek hatası: \(description)"
        case .decodingFailed(let description):
            return "Veri okuma hatası: \(description)"
        case .serverError(let reason):
            return "Sunucu Hatası: \(reason)"
        case .unknown:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}
