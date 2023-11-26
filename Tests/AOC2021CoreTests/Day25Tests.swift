//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 25.12.21.
//

import Foundation

import Foundation
import XCTest

@testable import AOC2021Core

final class Day25Tests: XCTestCase {
    var sut: Day25!

    let input = [
        "v...>>.vv>",
        ".vv>>.vv..",
        ">>.>v>...v",
        ">>v>>.>.v.",
        "v>v.vv.v..",
        ">.>>..v...",
        ".vv..>.>v.",
        "v.v..>>v.v",
        "....v..v.>",
    ]

    override func setUpWithError() throws {
        sut = try Day25()
    }

    func testPart1() {
        let data = input.getDay25Input()
        let res = sut.countUntilNoMovement(on: data.board, dim: data.dim)

        XCTAssertEqual(res, 58)
    }

}
