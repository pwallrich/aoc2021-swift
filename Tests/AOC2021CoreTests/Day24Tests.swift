//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 24.12.21.
//

import Foundation
import XCTest

@testable import AOC2021Core

final class Day24Tests: XCTestCase {
    var sut: Day24!

    override func setUpWithError() throws {
        sut = try Day24()
    }

    func testRunProgram() {
        let res = sut.run(programm: [
            "inp x",
            "mul x -1"
        ], inputs: [3])
        XCTAssertEqual(res, ["x": -3])
    }

    func testRunProgram2() {
        let res = sut.run(programm: [
            "inp w",
            "add w 1",
            "inp x",
            "mul x -2",
            "inp y",
            "div y 2",
            "inp z",
            "mod z 2",
            "inp a",
            "eql a 5",
            "inp b",
            "eql b 5"
        ], inputs: [1, 2, 4, 1, 4, 5])
        XCTAssertEqual(res, ["w": 2, "x": -4, "y": 2, "z": 1, "a": 0, "b": 1])
    }

    func testRunProgram3() {
        let res = sut.run(programm: [
            "inp v",
            "inp a",
            "add v a",

            "inp w",
            "inp b",
            "mul w b",

            "inp x",
            "inp c",
            "div x c",

            "inp y",
            "inp d",
            "mod y d",

            "inp z",
            "inp e",
            "eql z e",
        ], inputs: [1, 2,  3, 4,  8, 2,  7, 8,  9, 1])
        XCTAssertEqual(res, ["v": 3, "w": 12, "x": 4, "y": 7, "z": 0, "a": 2, "b": 4, "c": 2, "d": 8, "e": 1])
    }

    func testEval() {
        sut.getInstructions(with: sut.input)
    }
}
