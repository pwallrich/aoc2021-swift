//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 20.12.21.
//

import Foundation

class Day20: Day {
    let input: (board: Set<Point>, mask: String)

    init() throws {
        let input = try InputGetter.getInput(for: 20, part: .first)
            .components(separatedBy: "\n")
            .getDay20Data()

        self.input = input
    }

    func runPart1() throws {
        var res = input.board
        res = run(on: res, mask: input.mask)

        print("Day20 part1: \(res.count)")
    }

    func runPart2() throws {

    }

    func run(on board: Set<Point>, mask: String) -> Set<Point> {

        let maxY = board.max { $0.y < $1.y }!.y + 1
        let minY = board.min { $0.y < $1.y }!.y - 1
        let maxX = board.max { $0.x < $1.x }!.x + 1
        let minX = board.min { $0.x < $1.x }!.x - 1

        print(minY, maxY, minX, maxX)

        guard mask.starts(with: "#")  else {
            print("entering light mode")
            var res = board
            for _ in 0..<2 {
                let toUse = res
                res = []
                for y in minY...maxY {
                    for x in minX...maxX {
                        let newValue = process(point: Point(x: x, y: y), on: toUse, mask: mask)
                        if newValue == "#" {
                            res.insert(Point(x: x, y: y))
                        }
                    }
                }
            }
            return res
        }
        // first iteration - all should be turned on

        var res: Set<Point> = board
        var isInversed = false

        for i in 0..<50 {
            let toUse = res
            res = []
            let maxY = toUse.max { $0.y < $1.y }!.y + 1
            let minY = toUse.min { $0.y < $1.y }!.y - 1
            let maxX = toUse.max { $0.x < $1.x }!.x + 1
            let minX = toUse.min { $0.x < $1.x }!.x - 1

            for y in minY...maxY {
                for x in minX...maxX {
                    let newValue = process(point: Point(x: x, y: y), on: toUse, mask: mask, isInversed: isInversed)

                    if isInversed {
                        if newValue == "#" {
                            res.insert(Point(x: x, y: y))
                        }
                    } else {
                        if newValue == "." {
                            res.insert(Point(x: x, y: y))
                        }
                    }
                }
            }
            isInversed.toggle()
            if i == 1 {
                print("part1: \(res.count)")
            }
        }

        return res
    }

    func process(point: Point, on board: Set<Point>, mask: String, isInversed: Bool = false) -> Character {
//        print("--- start (\(point.x),\(point.y))  --- ")
        var str = ""
        for yOffset in (-1...1) {
            for xOffset in (-1...1) {
                let pTemp = Point(x: point.x + xOffset, y: point.y + yOffset)
//                        print("getting \(pTemp)")
                if board.contains(pTemp) {
                    str.append(isInversed ? "0" : "1")
                } else {
                    str.append(isInversed ? "1" : "0")
                }
            }
        }
        let intValue = Int(str, radix: 2)!
        let newValue = mask[mask.index(mask.startIndex, offsetBy: intValue)]
        return newValue
    }
}

extension Set where Element == Point {
    func printDay20() {
        let maxY = self.max { $0.y < $1.y }!.y
        let maxX = self.max { $0.x < $1.x }!.x
        for y in 0...maxY {
            for x in 0...maxX {
                let isSet = self.contains(Point(x: x, y: y))
                print(isSet ? "#" : "." , terminator: "")
            }
            print()
        }
    }
}

extension Array where Element == String {
    func getDay20Data() -> (board: Set<Point>, mask: String) {
        let mask = self[0]
        var board: Set<Point> = []
        for (y, row) in self.dropFirst(2).enumerated() {
            for (x, char) in row.enumerated() {
                if char == "#" {
                    board.insert(Point(x: x, y: y))
                }
            }
        }

        return (board, mask)
    }
}
