//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 18.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day18Tests: XCTestCase {
    var sut: Day18!

    override func setUpWithError() throws {
        sut = try .init()
    }

    func testPart2() {
        let input = [
            "[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]",
            "[[[5,[2,8]],4],[5,[[9,9],0]]]",
            "[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]",
            "[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]",
            "[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]",
            "[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]",
            "[[[[5,4],[7,7]],8],[[8,3],8]]",
            "[[9,3],[[9,9],[6,[4,9]]]]",
            "[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]",
            "[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]",
        ]
        let res = sut.getMaxPossible(in: input)

        XCTAssertEqual(res, 3993)
    }

    func testExplode() {
        let input = "[[[[[9,8],1],2],3],4]"
        let expected = "[[[[0,9],2],3],4]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode2() {
        let input = "[7,[6,[5,[4,[3,2]]]]]"
        let expected = "[7,[6,[5,[7,0]]]]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode3() {
        let input = "[[6,[5,[4,[3,2]]]],1]"
        let expected = "[[6,[5,[7,0]]],3]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode4() {
        let input = "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]"
        let expected = "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode5() {
        let input = "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"
        let expected = "[[3,[2,[8,0]]],[9,[5,[7,0]]]]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode6() {
        let input = "[[3,[2,[8,0]]],[[[[1,6],1],1],1]]"
        let expected = "[[3,[2,[8,1]]],[[[0,7],1],1]]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode7() {
        let input = "[3,[[[[1,6],1],1],1]]"
        let expected = "[4,[[[0,7],1],1]]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode8() {
        let input = "[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]"
        let expected = "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testExplode9() {
        let input = "[[[[[1,1],[2,2]],[3,3]],[4,4]],[5,5]]"
        let expected = "[[[[0,[3,2]],[3,3]],[4,4]],[5,5]]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testSplit() {
        let input = "[11,1]"
        let expected = "[[5,6],1]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testSplit2() {
        let input = "[12,1]"
        let expected = "[[6,6],1]"

        let res = sut.reduce(string: input)

        XCTAssertEqual(res.0, expected)
    }

    func testMultipleActions() {
        let f = "11"
        let s = "12"

        let res = sut.add(first: f, second: s)
        let expected = "[[5,6],[6,6]]"

        XCTAssertEqual(res, expected)
    }

    func testMultipleActions2() {
        let f = "[[[[4,3],4],4],[7,[[8,4],9]]]"
        let s = "[1,1]"

        let res = sut.add(first: f, second: s)
        let expected = "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"

        XCTAssertEqual(res, expected)
    }

    func testSum() {
        let input = [
            "[1,1]",
            "[2,2]",
            "[3,3]",
            "[4,4]",
        ]
        let res = sut.sum(rows: input)

        let expected = "[[[[1,1],[2,2]],[3,3]],[4,4]]"
        XCTAssertEqual(res, expected)
    }

    func testSum2() {
        let input = [
            "[1,1]",
            "[2,2]",
            "[3,3]",
            "[4,4]",
            "[5,5]",
        ]
        let res = sut.sum(rows: input)

        let expected = "[[[[3,0],[5,3]],[4,4]],[5,5]]"
        XCTAssertEqual(res, expected)
    }

    func testSum3() {
        let input = [
            "[1,1]",
            "[2,2]",
            "[3,3]",
            "[4,4]",
            "[5,5]",
            "[6,6]",
        ]
        let res = sut.sum(rows: input)

        let expected = "[[[[5,0],[7,4]],[5,5]],[6,6]]"
        XCTAssertEqual(res, expected)
    }

    func testSumLarge() {
        let input = [
            "[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]",
            "[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]",
            "[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]",
            "[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]",
            "[7,[5,[[3,8],[1,4]]]]",
            "[[2,[2,2]],[8,[8,1]]]",
            "[2,9]",
            "[1,[[[9,3],9],[[9,0],[0,7]]]]",
            "[[[5,[7,4]],7],1]",
            "[[[[4,2],2],6],[8,7]]",
        ]
        let res = sut.sum(rows: input)

        let expected = "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"
        XCTAssertEqual(res, expected)
    }

    func testMagnitude() {
        let input = "[[1,2],[[3,4],5]]"
        let res = sut.magnitude(row: input)
        XCTAssertEqual(res.result, 143)
    }

    func testMagnitude2() {
        let input = "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"
        let res = sut.magnitude(row: input)
        XCTAssertEqual(res.result, 1384)
    }

    func testMagnitude3() {
        let input = "[[[[1,1],[2,2]],[3,3]],[4,4]]"
        let res = sut.magnitude(row: input)
        XCTAssertEqual(res.result, 445)
    }

    func testMagnitude4() {
        let input = "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"
        let res = sut.magnitude(row: input)
        XCTAssertEqual(res.result, 3488)
    }
}
