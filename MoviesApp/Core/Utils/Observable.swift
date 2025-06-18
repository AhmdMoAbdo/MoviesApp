//
//  Observable.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

class Observable<T> {
    typealias observer = (T) -> Void
    
    private var observers: [observer] = []
    var value: T? {
        didSet {
            notifyObservers()
        }
    }
    
    init(value: T? = nil) {
        self.value = value
    }
    
    func bind(_ observer: @escaping observer) {
        self.observers.append(observer)
    }
    
    func onNext(_ value: T) {
        self.value = value
    }
    
    private func notifyObservers() {
        guard let value = value else { return }
        observers.forEach { $0(value) }
    }
}
