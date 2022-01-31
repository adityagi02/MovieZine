//
//  Movie.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import Foundation

struct MovieResponse: Decodable {
    
    let results: [Movie]
}


struct Movie: Decodable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String?
    
    let videos: MovieVideoResponse?
    
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-mm-yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
  
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w342\(posterPath ?? "")")!
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.dateFormatter.string(from: date)
    }
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
}


struct MovieVideoResponse: Decodable {
    
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
