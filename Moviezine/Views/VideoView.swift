//
//  VideoView.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI


struct VideoView: View {
    var body: some View {
        videoLoader(videoID: "JfVOs4VSpmA")
            .frame(width: 390, height: 300)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
