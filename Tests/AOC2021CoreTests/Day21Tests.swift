//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 21.12.21.
//

import Foundation
import XCTest

@testable import AOC2021Core

final class Day21Tests: XCTestCase {
    var sut: Day21!

    let input = (4, 8)

    override func setUpWithError() throws {
        sut = .init()
    }

    func testPart1() {
        let res = sut.deterministicRolll(input: input)
        XCTAssertEqual(res, 739785)
    }

    func testPart2() {
        let res = sut.rollWithSplitting(input: input)
        XCTAssertEqual(res, 444356092776315)
    }
}
