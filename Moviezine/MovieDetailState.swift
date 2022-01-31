//
//  MovieDetailState.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//
import SwiftUI

@MainActor
class MovieDetailState: ObservableObject {
    
    private let movieService: MovieService
    @Published private(set) var phase: DataFetchPhase<Movie?> = .empty
    var movie: Movie? {
        phase.value ?? nil
    }
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) async {
        if Task.isCancelled { return }
        phase = .empty
     
        do {
            let movie = try await self.movieService.fetchMovie(id: id)
            phase = .success(movie)
        } catch {
            phase = .failure(error)
        }
    }
}
