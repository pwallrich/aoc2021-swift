//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 07.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day7Tests: XCTestCase {
    let input = [16,1,2,0,4,2,7,1,2,14]

    func testPart1() throws {
        let sut = try Day7()
        let res = sut.getPointWithMinFuel(initial: input, calculate: sut.calculateFuel(for:initial:))
        XCTAssertEqual(res?.point, 2)
        XCTAssertEqual(res?.fuel, 37)
    }

    func testCalculateFuel() throws {
        let sut = try Day7()
        XCTAssertEqual(sut.calculateFuel(for: 1, initial: input), 41)
        XCTAssertEqual(sut.calculateFuel(for: 2, initial: input), 37)
        XCTAssertEqual(sut.calculateFuel(for: 3, initial: input), 39)
        XCTAssertEqual(sut.calculateFuel(for: 10, initial: input), 71)
    }

    func testCalculateFuelIncreasing() throws {
        let sut = try Day7()
        XCTAssertEqual(sut.calculateFuelIncreasing(for: 2, initial: input), 206)
        XCTAssertEqual(sut.calculateFuelIncreasing(for: 5, initial: input), 168)
    }

    func testPart2() throws {
        let sut = try Day7()
        let res = sut.getPointWithMinFuel(initial: input, calculate: sut.calculateFuelIncreasing(for:initial:))
        XCTAssertEqual(res?.point, 5)
        XCTAssertEqual(res?.fuel, 168)

    }

    func testGetFuelPart2() throws {
        let sut = try Day7()
        XCTAssertEqual(sut.getFuelPart2(initial: input), 168)
    }
}

