//
//  ResizableAsyncImage.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ResizableAsyncImage: View {
    let imageUrl: URL
    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case.success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 155, height: 155)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 155, height: 155)
                    .overlay(RoundedRectangle(cornerRadius: 5))
            @unknown default:
                EmptyView()
            }
        }
    }
}
