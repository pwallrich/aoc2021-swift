//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 08.12.21.
//

import Foundation
import XCTest
@testable import AOC2021Core

final class Day8Tests: XCTestCase {
    let input = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
"""

    func testPart2() throws {
    }

    func testPart1() throws {
        let input = input.components(separatedBy: "\n").splitInputAndOutput()
        let sut = try Day8()
        let res = sut.countOneFourSevenAndEightInOutputs(input: input)

        XCTAssertEqual(res, 26)
    }

    func testGetDigits() throws {
        let input = ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"].splitInputAndOutput()
        let sut = try Day8()
        let res = sut.getInputNumberMapping(input: input[0])

        XCTAssertEqual(res, [
            Set("acedgfb"): 8,
            Set("cdfbe"): 5,
            Set("gcdfa"): 2,
            Set("fbcad"): 3,
            Set("dab"): 7,
            Set("cefabd"): 9,
            Set("cdfgeb"): 6,
            Set("eafb"): 4,
            Set("cagedb"): 0,
            Set("ab"): 1
        ])
    }

    func testRowValue() throws {
        let input = ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"].splitInputAndOutput()
        let sut = try Day8()
        let res = sut.getRowValue(input: input[0])

        XCTAssertEqual(res, 5353)
    }

    func testCalculateValue() throws {
        let input = ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"].splitInputAndOutput()
        let sut = try Day8()
        let res = sut.calculateValue(input: input)

        XCTAssertEqual(res, 5353)
    }

    func testCalculateValue2() throws {
        let input = input.components(separatedBy: "\n").splitInputAndOutput()
        let sut = try Day8()
        let res = sut.calculateValue(input: input)

        XCTAssertEqual(res, 61229)
    }

    func test0thSegment() throws {
        let sut = try Day8()
        let res = sut.find0thSegment(input: [7: Set("abc"), 1: Set("ab")])

        XCTAssertEqual(res, "c")
    }
}

