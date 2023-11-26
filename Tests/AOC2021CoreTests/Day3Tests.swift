import XCTest
@testable import AOC2021Core

final class Day3Tests: XCTestCase {
    let input = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010",
    ]

    func testPart1() throws {
        let sut = try Day3()
        let res = sut.calculateGammaAndEpsilon(input: input)

        XCTAssertEqual(res.gamma, 22)
        XCTAssertEqual(res.epsilon, 9)
    }

    func testPart2() throws {
        let sut = try Day3()
        let res = sut.calculateOxygenAndCO2(input: input)

        XCTAssertEqual(res.oxygen, 23)
        XCTAssertEqual(res.co2, 10)
    }
}
