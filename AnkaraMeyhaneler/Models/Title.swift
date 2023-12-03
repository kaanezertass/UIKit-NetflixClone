//
//  Movie.swift
//  AnkaraMeyhaneler
//
//  Created by Kaan Ezerrtaş on 31.10.2023.
//

import Foundation


struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_app: String?
    let overview: String?
    let vote_count: Int
    let release_data: String?
    let vote_average: Double
}
