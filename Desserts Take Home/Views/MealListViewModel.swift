//
//  MealListViewModel.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Foundation
import SwiftUI

/// `MealListView`'s `ViewModel` companion.
@MainActor
final class MealListViewModel: ObservableObject {
    @Published private(set) var errorMessage: String?
    @Published private(set) var loading = false
    /// Filtered results.
    @Published private(set) var meals = [MealModel]()
    /// Allows the user to filter results in runtime.
    var searchText = "" {
        didSet {
            withAnimation {
                meals = allMeals.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText.lowercased()) }
            }
        }
    }

    private var allMeals = [MealModel]()
    private let service: MealServicing

    init(service: MealServicing = MealService()) {
        self.service = service
    }

    func bootstrap() {
        refresh()
    }

    func refresh() {
        guard !loading else { return }

        errorMessage = nil

        loading = true

        Task {
            do {
                allMeals = try await service.fetch(category: "Dessert")
                meals = allMeals
            } catch let error as InternalError {
                errorMessage = error.localizedDescription
            } catch {
                errorMessage = error.localizedDescription
            }

            loading = false
        }
    }
}
