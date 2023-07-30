//
//  DetailsPosterImageView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/26.
//

import Foundation
import SwiftUI

struct DetailsPosterImageView: View {
    
    var imageUrl: String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)){ phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
//                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, idealWidth: POSTER_IMAGE_WIDTH, maxWidth: POSTER_IMAGE_WIDTH, minHeight: 0, idealHeight: POSTER_IMAGE_HEIGHT, maxHeight: POSTER_IMAGE_HEIGHT)
                    .cornerRadius(MARGIN_SMALL)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                EmptyView()
            }
        }
        
    }
}
