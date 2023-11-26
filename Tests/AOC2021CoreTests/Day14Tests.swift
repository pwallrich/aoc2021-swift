//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 14.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day14Tests: XCTestCase {
    let input = [
        "NNCB",
        "CH -> B",
        "HH -> N",
        "CB -> H",
        "NH -> C",
        "HB -> C",
        "HC -> B",
        "HN -> C",
        "NN -> C",
        "BH -> H",
        "NC -> B",
        "NB -> B",
        "BN -> B",
        "BB -> N",
        "BC -> B",
        "CC -> N",
        "CN -> C",
    ]

    func testPart1() throws {
        let values = input.getDay14Data()
        let sut = Day14(input: values)
        let res = sut.getMinMaxDiff(element: values.element, mapping: values.mapping, stepCount: 10)
        XCTAssertEqual(res, 1588)
    }

    func testGetCharCount() throws {
        let values = input.getDay14Data()
        let sut = Day14(input: values)
        let res = sut.getCharCount(element: values.element, mapping: values.mapping, stepCount: 1)
        var expected: [Character: Int] = [:]
        for c in "NCNBCHB" {
            expected[c, default: 0] += 1
        }
        XCTAssertEqual(res, expected)
    }

    func testGetCharCount2() throws {
        let values = input.getDay14Data()
        let sut = Day14(input: values)
        let res = sut.getCharCount(element: values.element, mapping: values.mapping, stepCount: 2)
        var expected: [Character: Int] = [:]
        for c in "NBCCNBBBCBHCB" {
            expected[c, default: 0] += 1
        }
        XCTAssertEqual(res, expected)
    }
}

