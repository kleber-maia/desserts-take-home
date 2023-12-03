//
//  MealDetailView.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/7/23.
//

import SwiftUI

/// Depicts a `Meal` by presenting its ingredients, instructions.
struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel

    var body: some View {
        ZStack {
            if viewModel.loading {
                ProgressView {
                    Text(NSLocalizedString("global_wait", value: "Please wait...", comment: "Generic loading message"))
                        .font(.title2)
                }
            } else if let errorMessage = viewModel.errorMessage {
                ContentUnavailableView(errorMessage, systemImage: "exclamationmark.triangle")
            } else if let meal = viewModel.meal {
                ScrollView {
                    ZStack(alignment: .top) {
                        AsyncImage(url: meal.thumbnailUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 350)
                        .clipped()

                        LinearGradient(colors: [Color(uiColor: .systemBackground).opacity(0.75), Color(uiColor: .systemBackground).opacity(0.75), Color(uiColor: .systemBackground).opacity(0)], startPoint: .top, endPoint: .bottom)
                            .frame(height: 125)
                    }

                    VStack(alignment: .leading) {
                        Text(meal.name)
                            .font(.largeTitle)
                            .padding(.bottom)

                        Text(NSLocalizedString("section_ingredients", value: "Ingredients", comment: "Section title"))
                            .font(.title3)
                            .bold()

                        Grid {
                            ForEach(Array(zip(meal.ingredients, meal.measures)), id: \.0) { ingredient, measure in
                                GridRow {
                                    Image(systemName: "square.and.pencil")
                                    Text(verbatim: ingredient)
                                        .font(.headline)
                                        .fontWeight(.light)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(verbatim: measure)
                                        .font(.headline)
                                        .fontWeight(.light)
                                }
                            }
                        }
                        .padding(.bottom)

                        Text(NSLocalizedString("section_instructions", value: "Instructions", comment: "Section title"))
                            .font(.title3)
                            .bold()

                        Text(verbatim: meal.instructions)
                            .padding(.bottom)
                    }
                    .padding()
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    // TODO: inject some local / preview data
    MealDetailView(viewModel: MealDetailViewModel(id: "52859"))
}
