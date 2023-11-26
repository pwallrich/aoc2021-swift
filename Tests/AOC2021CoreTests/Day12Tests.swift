//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 12.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day12Tests: XCTestCase {
    let input = [
        "start-A",
        "start-b",
        "A-c",
        "A-b",
        "b-d",
        "A-end",
        "b-end",
    ]

    func testPart1Small() throws {
        let sut = try Day12()
        let res = sut.getNumberOfPathsToEnd(input: input.getDay12Caves(), canVisitTwice: false)
        XCTAssertEqual(res, 10)
    }

    func testPart1SmallRecursive() throws {
        let sut = try Day12()
        let caves = input.getDay12Caves()
        let res = sut.recursiveFind(input: caves, partial: [caves["start"]!])
        XCTAssertEqual(res.count, 10)
    }

    func testPart2Small() throws {
        let sut = try Day12()
        let res = sut.getNumberOfPathsToEnd(input: input.getDay12Caves(), canVisitTwice: true)
        XCTAssertEqual(res, 36)
    }

    func testPart2SmallRecursive() throws {
        let caves = input.getDay12Caves()
        let sut = Day12(input: caves)
        let res = sut.recursiveFindTwice(partial: ([], caves["start"]!, false))
        XCTAssertEqual(res, 36)
    }
}
