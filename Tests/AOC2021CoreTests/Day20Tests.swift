//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 20.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day20Tests: XCTestCase {
    var sut: Day20!

    let bigInput = [

        "..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..##" +
        "#..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###" +
        ".######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#." +
        ".#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#....." +
        ".#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.." +
        "...####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#....." +
        "..##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#",
        "",
        "#..#.",
        "#....",
        "##..#",
        "..#..",
        "..###",
    ]

    override func setUpWithError() throws {
        sut = try .init()
    }

    func testPart1() {
        let input = bigInput.getDay20Data()

        _ = sut.process(point: Point(x: 2, y: 2), on: input.board, mask: input.mask)

        let res = sut.run(on: input.board, mask: input.mask)

        XCTAssertEqual(res.count, 35)
    }
}
