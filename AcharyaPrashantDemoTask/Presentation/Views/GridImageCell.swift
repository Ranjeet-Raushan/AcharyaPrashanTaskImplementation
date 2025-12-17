//  GridImageCell.swift
//  AcharyaPrashantDemoTask

import SwiftUI

struct GridImageCell: View {

    let item: ImageItem
    let loader: ImageLoaderType

    @State private var uiImage: UIImage?
    @State private var isLoading = false
    @State private var error: String?
    @State private var cancellable: Cancellable?

    var body: some View {
        ZStack {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else if isLoading {
                ProgressView()
            } else if error != nil {
                Color.gray.opacity(0.3)
                    .overlay(
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                    )
            } else {
                Color.gray.opacity(0.3)
            }
        }
        .onAppear { load() }
        .onDisappear { cancel() }
    }

    private func load() {
        guard uiImage == nil, !isLoading else { return }
        isLoading = true
        error = nil
        cancellable = loader.loadImage(from: item.url) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let image):
                    self.uiImage = image
                case .failure(let err):
                    self.error = err.localizedDescription
                }
            }
        }
    }

    private func cancel() {
        cancellable?.cancel()
        loader.cancelLoad(for: item.url)
    }
}
