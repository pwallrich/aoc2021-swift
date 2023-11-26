//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 06.12.21.
//


import Foundation
import XCTest
@testable import AOC2021Core

final class Day6Tests: XCTestCase {
    let input = [3,4,3,1,2]

    func testPart1() throws {
        let sut = try Day6()
        let res = sut.getAmountAfter(days: 80, initial: input)

        XCTAssertEqual(res, 5934)
    }

    func testPart2() throws {
        let sut = try Day6()
        let res = sut.getAmountAfter(days: 256, initial: input)

        XCTAssertEqual(res, 26984457539)
    }
}
