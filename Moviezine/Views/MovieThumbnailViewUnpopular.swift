//
//  MovieThumbnailViewUnpopular.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI

enum MovieThumbnailTypeUnp {
    case poster(showTitle: Bool = true)
    case backdrop
}

struct MovieThumbnailViewUnpopular: View {
    
    let movie: Movie
    var thumbnailType: MovieThumbnailTypeUnp = .poster()
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        containerView
        .onAppear {
                imageLoader.loadImage(with: movie.posterURL)
        }
    }
    
    @ViewBuilder
    private var containerView: some View {
        if case .backdrop = thumbnailType {
        HStack(spacing: 8) {
                imageView
                 }
        } else {
            imageView
         }
    }
    private var imageView: some View {
        HStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 194.5, height: 258, alignment: .leading)
            }
            if case .poster(let showTitle) = thumbnailType, showTitle {
                Text(movie.title)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                    .lineLimit(4)
                    .position(x: 60, y: 80)
            }
        }
        .padding()
        .frame(width: 350.0, height: 231.0)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}


struct MovieUnpopularPosterCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieThumbnailViewUnpopular(movie: Movie.stubbedMovie, thumbnailType: .poster(showTitle: true))
                .frame(width: 204, height: 306)
.previewInterfaceOrientation(.portrait)
            MovieThumbnailViewUnpopular(movie: Movie.stubbedMovie, thumbnailType: .poster(showTitle: true))
                .frame(width: 204, height: 306)
            MovieThumbnailViewUnpopular(movie: Movie.stubbedMovie, thumbnailType: .backdrop)
                .aspectRatio(16/9, contentMode: .fit)
                .frame(height: 160)
        }
    }
}
