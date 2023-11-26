//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 05.12.21.
//

import Foundation

struct Line: Sequence {
    let p1: Point
    let p2: Point

    func makeIterator() -> LineIterator {
        return LineIterator(self)
    }
}

struct LineIterator: IteratorProtocol {
    private let line: Line
    private var current: Point?

    init(_ line: Line) {
        self.line = line
    }

    private func nextPosition() -> Point? {
        guard current != line.p2 else {
            return nil
        }
        guard let current = current else {
            return line.p1
        }
        // calculate step number
        // signum returns -1 if negativ, 1 if positiv and 0 if zerox
        let dx = (line.p2.x - current.x).signum()
        let dy = (line.p2.y - current.y).signum()

        return Point(x: current.x + dx, y: current.y + dy)
    }

    mutating func next() -> Point? {
        if let nextP = nextPosition() {
            self.current = nextP
            return nextP
        }
        return nil
    }
}

class Day5: Day {
    private let input: [String]

    init() throws {
        self.input = try InputGetter.getInput(for: 5, part: .first)
            .split(separator: "\n")
            .map(String.init)
    }

    func runPart1() throws {
        let res = getNumOfPointsExistingMultipleTimes(input: input)
        print("result day 5 Part 1: \(res)")
    }

    func runPart2() throws {
        let res = getNumOfPointsExistingMultipleTimesWithVertical(input: input)
        print("result day 5 Part 2: \(res)")
    }

    func getNumOfPointsExistingMultipleTimes(input: [String]) -> Int {
        var board: [Point: Int] = [:]
        var res: Int = 0
        for expr in input {
            let (p1, p2) = getPositions(from: expr)

            guard p1.x == p2.x || p1.y == p2.y else {
                print("skipping diagonal lines")
                continue
            }

            for p in Line(p1: p1, p2: p2) {
                board[p, default: 0] += 1
                if board[p] == 2 {
                    res += 1
                }
            }
        }
        return res
    }

    func getNumOfPointsExistingMultipleTimesWithVertical(input: [String]) -> Int {
        var board: [Point: Int] = [:]
        var res: Int = 0
        for expr in input {
            let (p1, p2) = getPositions(from: expr)

            for p in Line(p1: p1, p2: p2) {
                board[p, default: 0] += 1
                if board[p] == 2 {
                    res += 1
                }
            }
        }
        return res
    }

    private func getPositions(from line: String) -> (Point, Point) {
        let values = line.matches(for: "(\\d+)").map { Int($0)! }
        assert(values.count == 4, "There must be 4 numbers")
        return (Point(x: values[0], y: values[1]), Point(x: values[2], y: values[3]))
    }
}
