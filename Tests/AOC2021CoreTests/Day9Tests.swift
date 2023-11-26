//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 09.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day9Tests: XCTestCase {
    let input = [
        "2199943210",
        "3987894921",
        "9856789892",
        "8767896789",
        "9899965678",
        ]

    func testPart1() throws {
        let sut = try Day9()
        let res = sut.getRiskLevelOfLowPoints(in: input)

        XCTAssertEqual(res, 15)
    }

    func testPart2() throws {
        let sut = try Day9()
        let res = sut
            .getBaisinsValue(in: input)

        XCTAssertEqual(res, 1134)
    }

    func testGetBaisins() throws {
        let sut = try Day9()
        let res = sut
            .getBaisins(in: input.getDictOfGrid())
            .map { $0.sorted(by: <) }

        XCTAssert(res.contains([1, 2, 3]))
        XCTAssert(res.contains([0, 1, 1, 2, 2, 2, 3, 4, 4]))
        XCTAssert(res.contains([0, 1, 1, 2, 2, 2, 3, 4, 4]))
        XCTAssert(res.contains([5, 6, 6, 6, 7, 7, 8, 8, 8]))
        XCTAssert(res.contains([5, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]))

    }
}
