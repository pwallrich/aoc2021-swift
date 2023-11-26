//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 05.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day5Tests: XCTestCase {
    let input = [
        "0,9 -> 5,9",
        "8,0 -> 0,8",
        "9,4 -> 3,4",
        "2,2 -> 2,1",
        "7,0 -> 7,4",
        "6,4 -> 2,0",
        "0,9 -> 2,9",
        "3,4 -> 1,4",
        "0,0 -> 8,8",
        "5,5 -> 8,2",
    ]

    func testPart1() throws {
        let sut = try Day5()
        let res = sut.getNumOfPointsExistingMultipleTimes(input: input)

        XCTAssertEqual(res, 5)
    }

    func testPart2() throws {
        let sut = try Day5()
        let res = sut.getNumOfPointsExistingMultipleTimesWithVertical(input: input)

        XCTAssertEqual(res, 12)
    }
}
