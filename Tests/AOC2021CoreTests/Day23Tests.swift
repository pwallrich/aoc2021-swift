//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 23.12.21.
//

import Foundation
import XCTest

@testable import AOC2021Core

final class Day23Tests: XCTestCase {
    var sut: Day23!

    var board: [Point: Character] = {
        var board: [Point: Character] = [:]
        board[Point(x: 2, y: -1)] = "B"
        board[Point(x: 2, y: -2)] = "A"

        board[Point(x: 4, y: -1)] = "C"
        board[Point(x: 4, y: -2)] = "D"

        board[Point(x: 6, y: -1)] = "B"
        board[Point(x: 6, y: -2)] = "C"

        board[Point(x: 8, y: -1)] = "D"
        board[Point(x: 8, y: -2)] = "A"
        return board
    }()

    override func setUpWithError() throws {
        sut = .init(board: board)
    }

    func testPart1() {
        let res = sut.advance(board: board)

        print("took route:")
        print("----------------------")
        var total = 0
        for step in res!.route {
            print("moved \(step.value) from \(step.old) to \(step.new), cost: \(moveMap[step.value]!)")
            total += moveMap[step.value]! * step.old.manhattan(to: step.new)
            print("total: \(total)")
            step.board.debugLog(isBigBoard: false)
            print()
        }

        print("----------------------")
        XCTAssertEqual(res?.0, 12521)
    }

    func testMoveRight() {
//        #############
//        #BB.D.D.....#
//        ###.#.#C#.###
//        ###A#.#C#A###
//        #############
        var board: [Point: Character] = [:]
        board[Point(x: 0, y: 0)] = "B"
        board[Point(x: 1, y: 0)] = "B"

        board[Point(x: 3, y: 0)] = "D"
        board[Point(x: 5, y: 0)] = "D"

        board[Point(x: 2, y: -2)] = "A"
        board[Point(x: 6, y: -2)] = "C"

        board[Point(x: 6, y: -1)] = "C"
        board[Point(x: 8, y: -2)] = "A"

        let res = sut.advance(board: board)

        XCTAssertEqual(res?.0, 3 * 1 + 5 * 1000 + 6 * 1000 + 5 * 10 + 5 * 10 + 8 * 1)
        
    }

}
