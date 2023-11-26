//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 11.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day11Tests: XCTestCase {
    let input = [
        "5483143223",
        "2745854711",
        "5264556173",
        "6141336146",
        "6357385478",
        "4167524645",
        "2176841721",
        "6882881134",
        "4846848554",
        "5283751526",
    ]

    func testPart1() throws {
        let sut = try Day11()
        let res = sut.getNumberOfFlashes(until: 100, input: input)
        XCTAssertEqual(res, 1656)
    }

    func testAdvanceWithBigInput() throws {
        let sut = try Day11()
        let res1 = sut.advanceOneStep(board: input.getDictOfGrid())
        let expected1 = [
            "6594254334",
            "3856965822",
            "6375667284",
            "7252447257",
            "7468496589",
            "5278635756",
            "3287952832",
            "7993992245",
            "5957959665",
            "6394862637",
        ].getDictOfGrid()
        XCTAssertEqual(res1.board, expected1)
        XCTAssertEqual(res1.flashes, 0)
    }

    func testAdvanceOneStep() throws {
        let sut = try Day11()
        let input = [
            "11111",
            "19991",
            "19191",
            "19991",
            "11111",
        ].getDictOfGrid()
        let res = sut.advanceOneStep(board: input)

        let expected = [
            "34543",
            "40004",
            "50005",
            "40004",
            "34543",
        ].getDictOfGrid()

        XCTAssertEqual(res.board, expected)
        XCTAssertEqual(res.flashes, 9)

        let resStep2 = sut.advanceOneStep(board: res.board)
        let expectedAfterStep2 = [
            "45654",
            "51115",
            "61116",
            "51115",
            "45654",
        ].getDictOfGrid()

        XCTAssertEqual(resStep2.board, expectedAfterStep2)
        XCTAssertEqual(resStep2.flashes, 0)
    }

    func testPart2() throws {
        let sut = try Day11()
        let res = sut.getStepWhenAllSynced(input: input)
        XCTAssertEqual(res, 195)
    }
}
