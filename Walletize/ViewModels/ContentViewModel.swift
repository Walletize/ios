//
//  ContentViewModel.swift
//  Walletize
//
//  Created by Yap Justin on 04/02/24.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var token: String?
    
    init() {
        service.$token
            .sink { [weak self] token in
                self?.token = token
            }
            .store(in: &cancellables)
    }
}
