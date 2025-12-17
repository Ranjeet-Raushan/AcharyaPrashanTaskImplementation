//  ImageGridViewModel.swift
//  AcharyaPrashantDemoTask

import SwiftUI
import Combine
import Foundation

@MainActor
final class ImageGridViewModel: ObservableObject {

    @Published var items: [ImageItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchUseCase: FetchMediaCoveragesUseCaseType 
    private var fetchTask: Cancellable?

    init(fetchUseCase: FetchMediaCoveragesUseCaseType) {
        self.fetchUseCase = fetchUseCase
    }

    func load() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        fetchTask = fetchUseCase.execute(limit: 250) { [weak self] (result: Result<[ImageItem], Error>)  in
            Task { @MainActor in
                guard let self else { return }
                self.isLoading = false
                switch result {
                case .success(let items):
                    self.items = items
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func cancelLoad() {
        fetchTask?.cancel()
    }
}
