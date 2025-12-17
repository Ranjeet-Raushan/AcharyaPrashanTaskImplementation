//  Cancellable.swift
//  RanjeetTask
//  Created by Ranjeet Raushan on 14/12/25.

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionDataTask: Cancellable {}
