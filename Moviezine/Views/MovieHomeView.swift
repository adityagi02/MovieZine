//
//  MovieHomeView.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI

struct MovieHomeView: View {
    
    @StateObject private var movieHomeState = MovieHomeState()
    
    var body: some View {
        VStack{
          List {
              ForEach(movieHomeState.sections) {
                MovieThumbnailCarouselView(
                    movies: $0.movies
                )
            }
            
            .listRowInsets(.init(top: -70, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
          .task { loadMovies(invalidateCache: false) }
          .listStyle(.plain)
    }
}
    
    @Sendable
    private func loadMovies(invalidateCache: Bool) {
        Task { await movieHomeState.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache) }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieHomeView()
        }
    }
}

