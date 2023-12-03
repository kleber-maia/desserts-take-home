//
//  MealDetailViewModel.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/7/23.
//

import SwiftUI

/// `MealDetailView`'s `ViewModel` companion.
final class MealDetailViewModel: ObservableObject {
    @Published private(set) var errorMessage: String?
    @Published private(set) var meal: MealDetailModel?
    @Published private(set) var loading = false

    private let id: String
    private let service: MealDetailServicing

    init(id: String, service: MealDetailServicing = MealDetailService()) {
        self.id = id
        self.service = service
    }

    func fetchData() {
        guard !loading else { return }

        errorMessage = nil

        loading = true

        Task { @MainActor in
            do {
                meal = try await service.fetch(id: id)
            } catch let error as InternalError {
                errorMessage = error.localizedDescription
            } catch {
                errorMessage = error.localizedDescription
            }

            loading = false
        }
    }
}
