//
//  videoLoader.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI
import WebKit



struct videoLoader: UIViewRepresentable {
   
   let videoID: String?
   
   func makeUIView(context: Context) -> WKWebView {
     return WKWebView()
   }
   
   func updateUIView(_ uiView: WKWebView, context: Context) {
       guard let youtubeurl = URL(string: "https://www.youtube.com/embed/\(videoID ?? "JfVOs4VSpmA")") else {return}
       uiView.scrollView.isScrollEnabled = false
       uiView.load(URLRequest(url: youtubeurl))
   }
   
}
