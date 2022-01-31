//
//  MovieThumbnailCarouselView.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI

struct MovieThumbnailCarouselView: View {
    
    let movies: [Movie]
    var thumbnailType: MovieThumbnailType = .poster()
    var thumbnailTypeUnp: MovieThumbnailTypeUnp = .poster()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack() {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                            if(movie.voteAverage > 7){
                                MovieThumbnailView(movie: movie, thumbnailType: thumbnailType)
                                    .movieThumbnailViewFrame(thumbnailType: thumbnailType)
                            }
                            else{
                                MovieThumbnailViewUnpopular(movie: movie, thumbnailType: thumbnailTypeUnp)
                                    .movieThumbnailViewFrame(thumbnailType: thumbnailType)
                            }
                        }.buttonStyle(.plain)
                    }
                }
            }.padding([.top, .leading, .trailing])
        }
    }
}

fileprivate extension View {
    
    @ViewBuilder
    func movieThumbnailViewFrame(thumbnailType: MovieThumbnailType) -> some View {
        switch thumbnailType {
        case .poster:
            self.frame(width: 342.0, height: 244.0)
        case .backdrop:
            self
                .aspectRatio(16/9, contentMode: .fit)
                .frame(height: 160)
        }
    }
    
    @ViewBuilder
    func movieThumbnailViewFrame(thumbnailType: MovieThumbnailTypeUnp) -> some View {
        switch thumbnailType {
        case .poster:
            self.frame(width: 342.0, height: 239.0)
        case .backdrop:
            self
                .aspectRatio(16/9, contentMode: .fit)
                .frame(height: 160)
        }
    }
}


struct MoviePosterCarouselView_Previews: PreviewProvider {
    
    static let stubbedMovies = Movie.stubbedMovies
    static var previews: some View {
        MovieThumbnailCarouselView( movies: stubbedMovies, thumbnailType: .poster(showTitle: false))
            .environment(\.sizeCategory, .large)
    }
}
