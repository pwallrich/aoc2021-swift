//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 13.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day13Tests: XCTestCase {
    let input = [
        "6,10",
        "0,14",
        "9,10",
        "0,3",
        "10,4",
        "4,11",
        "6,0",
        "6,12",
        "4,1",
        "0,13",
        "10,12",
        "3,4",
        "3,0",
        "8,4",
        "1,10",
        "2,14",
        "8,10",
        "9,0",
        "",
        "fold along y=7",
        "fold along x=5",
    ]

    func testPart1() throws {
        let sut = try Day13()
        let inputData = input.getDay13Data()
        let res = sut.fold(board: inputData.board, instructions: Array(inputData.instructions[0..<1]))

        XCTAssertEqual(res.count, 17)

        let res2 = sut.fold(board: res, instructions: Array(inputData.instructions[1..<2]))
        
        XCTAssertEqual(res2.count, 16)
    }

    func testPart2() throws {
        let sut = try Day13()
        let inputData = input.getDay13Data()
        let res = sut.fold(board: inputData.board, instructions: inputData.instructions)

        XCTAssertEqual(res.count, 16)
    }
}
