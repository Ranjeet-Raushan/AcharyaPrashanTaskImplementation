//  FetchMediaCoveragesUseCaseType.swift
//  AcharyaPrashantDemoTask

 protocol FetchMediaCoveragesUseCaseType {
    func execute(limit: Int,
                 completion: @escaping (Result<[ImageItem], Error>) -> Void) -> Cancellable?
}
