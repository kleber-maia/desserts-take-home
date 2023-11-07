//
//  MealListView.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import SwiftUI

/// Depicts a list of `Meals` where the user can navigate into details.
struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.loading {
                ProgressView {
                    Text(NSLocalizedString("global_wait", value: "Please wait...", comment: "Generic loading message"))
                        .font(.title2)
                }
            } else {
                List(viewModel.meals) { meal in
                    MealListItemView(meal: meal)
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText)
                .refreshable {
                    viewModel.refresh()
                }
                .navigationTitle(NSLocalizedString("meals_list_title", value: "Desserts", comment: "Screen title"))
                .navigationDestination(for: MealModel.self, destination: { meal in
                    MealDetailView(
                        viewModel: MealDetailViewModel(id: meal.id)
                    )
                })
                .overlay {
                    if let errorMessage = viewModel.errorMessage {
                        ContentUnavailableView(errorMessage, systemImage: "exclamationmark.triangle")
                    } else if viewModel.meals.isEmpty {
                        ContentUnavailableView.search
                    }
                }
            }
        }
        .tint(.primary)
        .onAppear {
            viewModel.bootstrap()
        }
    }
}

#Preview {
    // TODO: inject some local / preview data
    MealListView()
}
