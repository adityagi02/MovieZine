//
//  MovieThumbnailView.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI

enum MovieThumbnailType {
    case poster(showTitle: Bool = true)
    case backdrop
}

struct MovieThumbnailView: View {
    
    let movie: Movie
    var thumbnailType: MovieThumbnailType = .poster()
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        containerView
        .onAppear {
            switch thumbnailType {
            case .poster:
                imageLoader.loadImage(with: movie.posterURL)
            case .backdrop:
                imageLoader.loadImage(with: movie.posterURL)
            }
        }
    }
    
    @ViewBuilder
    private var containerView: some View {
        if case .backdrop = thumbnailType {
            VStack(alignment: .leading, spacing: 8) {
                imageView
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)
            }
        } else {
            imageView
        }
    }
    
 
private var imageView: some View {
    ZStack {
        Color.gray.opacity(0.3)
            .cornerRadius(10)
        
        if case .poster(let showTitle) = thumbnailType, showTitle {
            Text(movie.title)
                .multilineTextAlignment(.center)
                .padding(.vertical)
                .lineLimit(4)
        }
        
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable(resizingMode: .stretch)
                .cornerRadius(10)
        }
    }
    .padding()
    .frame(width: 389.0, height: 258.0)
    .cornerRadius(8)
    .shadow(radius: 4)
   }
}
 


struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieThumbnailView(movie: Movie.stubbedMovie, thumbnailType: .poster(showTitle: true))
                .frame(width: 204, height: 306)
        }
    }
}
