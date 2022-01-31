//
//  MovieDetailView.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    
    let movieId: Int
    let movieTitle: String
    @StateObject private var movieDetailState = MovieDetailState()
    @State private var selectedTrailerURL: URL?
    
    var body: some View {
        List {
            if let movie = movieDetailState.movie {
                HStack{
                    VideoView()
                        .scaledToFit()
                        .padding(.leading, -20.0)
                        .listRowSeparator(.hidden)
                }
                MovieDetailListView(movie: movie, selectedTrailerURL: $selectedTrailerURL)
            }
        }
        .listStyle(.plain)
        .task(loadMovie)
        .overlay(DataFetchPhaseOverlayView(
            phase: movieDetailState.phase,
            retryAction: loadMovie)
        )
        .sheet(item: $selectedTrailerURL) { SafariView(url: $0).edgesIgnoringSafeArea(.bottom)}
        .navigationTitle(movieTitle)
    }
    
    @Sendable
    private func loadMovie() {
        Task { await self.movieDetailState.loadMovie(id: self.movieId) }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    @Binding var selectedTrailerURL: URL?
    
    var body: some View {
        movieDescriptionSection.listRowSeparator(.hidden)
    }
    private var movieDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(movieGenreYearDurationText)
                .font(.headline)
            if !movie.ratingText.isEmpty {
                Text(movie.ratingText).foregroundColor(.yellow)
            }
            Text(movie.overview)
        }
        .padding(.vertical)
    }
    
  
@ViewBuilder
    private var movieTrailerSection: some View {
       
        if let trailers = movie.youtubeTrailers, !trailers.isEmpty {
            Text("Trailers").font(.headline)
            ForEach(trailers) { trailer in
                Button(action:  {
                    guard let url = trailer.youtubeURL else { return }
                    selectedTrailerURL = url }) {}
            }
            videoLoader(videoID: "CX-BdDHW0Ho")
        }
    }
    
 
    private var movieGenreYearDurationText: String {
        "Release Date: \(movie.yearText)"
    }
}

struct MovieDetailImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear { imageLoader.loadImage(with: imageURL) }
    }
}

extension URL: Identifiable {
    public var id: Self { self }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id, movieTitle:  Movie.stubbedMovie.title)
        }
.previewInterfaceOrientation(.portrait)
    }
}
