//
//  MealDetailModelTests.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

final class MealDetailModelTests: XCTestCase {
    func testDecode_whenDataIsValid() throws {
        // Arrange
        guard
            let jsonUrl = Bundle(for: Self.self).url(forResource: "creme_brulee", withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonUrl)
        else {
            XCTFail("JSON fixture couldn't be found")
            return
        }

        // Act
        let actual = try MealDetailModel.decode(from: jsonData)

        // Assert
        XCTAssertEqual(actual?.id, "52917")
        XCTAssertEqual(actual?.name, "White chocolate creme brulee")
        XCTAssertEqual(actual?.thumbnailUrl.absoluteString, "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg")
        XCTAssertEqual(actual?.category, "Dessert")
        XCTAssertEqual(actual?.area, "French")
        XCTAssertEqual(actual?.instructions, "Heat the cream, chocolate and vanilla pod in a pan until the chocolate has melted. Take off the heat and allow to infuse for 10 mins, scraping the pod seeds into the cream. If using the vanilla extract, add straight away. Heat oven to 160C/fan 140C/gas 3.\r\nBeat yolks and sugar until pale. stir in the chocolate cream. Strain into a jug and pour into ramekins. Place in a deep roasting tray and pour boiling water halfway up the sides. Bake for 15-20 mins until just set with a wobbly centre. Chill in the fridge for at least 4 hrs.\r\nTo serve, sprinkle some sugar on top of the brûlées and caramelise with a blowtorch or briefly under a hot grill. Leave caramel to harden, then serve.")
        XCTAssertEqual(actual?.tags, "Desert,DinnerParty,Pudding")
        XCTAssertEqual(actual?.youtubeUrl?.absoluteString, "https://www.youtube.com/watch?v=LmJ0lsPLHDc")
        XCTAssert(actual!.ingredients.contains("Double Cream"))
        XCTAssert(actual!.ingredients.contains("White Chocolate Chips"))
        XCTAssert(actual!.ingredients.contains("Vanilla"))
        XCTAssert(actual!.ingredients.contains("Egg Yolks"))
        XCTAssert(actual!.ingredients.contains("Caster Sugar"))
        XCTAssert(actual!.ingredients.contains("Caster Sugar"))
        XCTAssert(actual!.measures.contains("568ml"))
        XCTAssert(actual!.measures.contains("100g"))
        XCTAssert(actual!.measures.contains("Pod of"))
        XCTAssert(actual!.measures.contains("6"))
        XCTAssert(actual!.measures.contains("2 tbs"))
        XCTAssert(actual!.measures.contains("Top"))
    }

    func testDecode_whenDataFormatIsInvalid() throws {
        // Arrange
        let jsonData = "{someData:[something:123]}".data(using: .utf8)!

        // Act / Assert
        XCTAssertThrowsError(try MealDetailModel.decode(from: jsonData))
    }
}
