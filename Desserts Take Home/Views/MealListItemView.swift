//
//  MealListItemView.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import SwiftUI

/// Depicts a `Meal` with its thumbnail as a background and its name as a title.
struct MealListItemView: View {
    var meal: MealModel

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: meal.thumbnailUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .background {
                NavigationLink(value: meal) {}
            }
            .frame(height: 150)

            Text(meal.name)
                .font(.headline)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(.ultraThinMaterial)
        }
        .listRowSeparator(.hidden)
        .background(.white)
        .cornerRadius(16)
    }
}

#Preview {
    MealListItemView(
        meal: MealModel(
            id: "?", name: "White chocolate creme brulee", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg")!
        )
    )
    .padding()
}
