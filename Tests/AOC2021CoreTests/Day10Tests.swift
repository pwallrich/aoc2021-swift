//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 10.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day10Tests: XCTestCase {
    let input = [
        "[({(<(())[]>[[{[]{<()<>>",
        "[(()[<>])]({[<{<<[]>>(",
        "{([(<{}[<>[]}>{[]{[(<()>",
        "(((({<>}<{<{<>}{[]{[]{}",
        "[[<[([]))<([[{}[[()]]]",
        "[{[{({}]{}}([{[{{{}}([]",
        "{<[[]]>}<{[{[{[]{()[[[]",
        "[<(<(<(<{}))><([]([]()",
        "<{([([[(<>()){}]>(<<{{",
        "<{([{{}}[<[[[<>{}]]]>[]]",
    ]

    func testPart1() throws {
        let sut = try Day10()
        let res = sut.getIncorrectLineScore(in: input)
        XCTAssertEqual(res, 26397)
    }

    func testPart1Manual() throws {
        let sut = try Day10()
        let input = [
            "[)]",
            "[)",
            ")",
            "[([)]",
            "[()",

            "(]",
            "{()()()>",
            "(((()))}",
            "<([]){()}[{}])"
        ]
        let res = sut.getIncorrectLineScore(in: input)
        XCTAssertEqual(res, 12 + 57 + 1197 + 25137 + 3)
    }

    func testPart2() throws {
        let sut = try Day10()
        let res = sut.getMiddleScore(in: input)
        XCTAssertEqual(res, 288957)
    }

    func testGetScores() throws {
        let sut = try Day10()
        let res = sut.getScoresFor(input: input)

        let expected = [
            288957,
            5566,
            1480781,
            995444,
            294
        ]

        XCTAssertEqual(res, expected)
    }

    func testGetClosingString() throws {
        let sut = try Day10()
        let res = input.compactMap { sut.getClosingString(input: $0) }

        let expected = [
            "}}]])})]",
            ")}>]})",
            "}}>}>))))",
            "]]}}]}]}>",
            "])}>"
        ]

        XCTAssertEqual(res, expected)
    }
}
