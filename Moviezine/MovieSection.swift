//
//  MovieSection.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import Foundation

struct MovieSection: Identifiable {
    
    let id = UUID()
    
    let movies: [Movie]
    let endpoint: MovieListEndpoint
  
    var thumbnailType: MovieThumbnailType {
        endpoint.thumbnailType
    }
}

fileprivate extension MovieListEndpoint {
    
    var thumbnailType: MovieThumbnailType {
        switch self {
        case .nowPlaying:
            return .poster()
        }
    }
    
}
