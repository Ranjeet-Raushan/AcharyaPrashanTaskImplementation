//  ImageGridView.swift
//  AcharyaPrashantDemoTask


import SwiftUI
import Foundation


struct ImageGridView: View {

    @StateObject private var viewModel: ImageGridViewModel
    private let imageLoader: ImageLoaderType

    init() {
        
        let apiClient: MediaCoverageAPIClientType = MediaCoverageAPIClient()
        let useCase: FetchMediaCoveragesUseCaseType = FetchMediaCoveragesUseCase(apiClient: apiClient)
        
        let memoryCache = MemoryImageCache()
               let diskCache = DiskImageCache()
               let compositeCache = CompositeImageCache(memory: memoryCache, disk: diskCache)

        
        let loader = ImageLoader(cache: compositeCache)
        _viewModel = StateObject(wrappedValue: ImageGridViewModel(fetchUseCase: useCase))
        self.imageLoader = loader
    }

    private func columns(for width: CGFloat) -> [GridItem] {
        let minItemSize: CGFloat = 100
        let spacing: CGFloat = 8
        let columnsCount = max(2, Int((width + spacing) / (minItemSize + spacing)))
        return Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnsCount)
    }

    var body: some View {
        GeometryReader { geo in
            let cols = columns(for: geo.size.width)
            ScrollView {
                LazyVGrid(columns: cols, spacing: 8) {
                    ForEach(viewModel.items) { item in
                        GridImageCell(item: item, loader: imageLoader)
                            .aspectRatio(1.0, contentMode: ContentMode.fit)
                    }
                }
                .padding(8)
            }
            .overlay(alignment: .center) {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .overlay(alignment: .top) {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(8)
                        .padding()
                }
            }
            .onAppear { viewModel.load() }
            .onDisappear { viewModel.cancelLoad() }
        }
    }
}
#Preview {
    ImageGridView()
}
