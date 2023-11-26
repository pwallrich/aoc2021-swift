//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 15.12.21.
//

import Foundation

class Day15: Day {
    let input: [Point: Int]
    let count: Int
    init() throws {
        let input = try InputGetter.getInput(for: 15, part: .first)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }


        self.count = input.count
        self.input = input.getDay15Board()
    }

    func runPart1() throws {
        let res = getCheapestRoute(input: input, endPoint: Point(x: count - 1 , y: count - 1))
        print("Day15 Part1: \(res)")
    }

    func runPart2() throws {
        let start = CFAbsoluteTimeGetCurrent()
        let res = getCheapestRouteCopyingElement(input: input, size: count)
        print("Day15 Part2: \(res)")
        print("took: \(CFAbsoluteTimeGetCurrent() - start)")
    }

    func getCheapestRouteCopyingElement(input: [Point: Int], size: Int) -> Int {
        let copiedBoard = makeFullMap(from: input, size: size)
        let newEndPoint = Point(x: size * 5 - 1, y: size * 5 - 1)
        let start = CFAbsoluteTimeGetCurrent()
        let res = getCheapestRoute(input: copiedBoard, endPoint: newEndPoint)
        print("A* took \(CFAbsoluteTimeGetCurrent() - start)")
        return res
    }

    func getCheapestRoute(input: [Point: Int], endPoint: Point) -> Int {
        var open: [Point: Int] = [:]
        var costSoFar: [Point: Int] = [:]

        open[Point(x: 0, y: 0)] = 0
        costSoFar[Point(x: 0, y: 0)] = 0
        while !open.isEmpty {
            let current = open.min { $0.value < $1.value }!
            open[current.key] = nil

            if current.key == endPoint {
                return costSoFar[current.key]!
            }

            for offsets in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let newPoint = Point(x: current.key.x + offsets.0, y: current.key.y + offsets.1)
                guard
                    let value = input[newPoint]
                else {
                    continue
                }
                let newCost = costSoFar[current.key]! + value
                if newCost < (costSoFar[newPoint] ?? .max) {
                    costSoFar[newPoint] = newCost
                    open[newPoint] = newCost + manhattanDistance(a: newPoint, b: endPoint)
                }
            }
        }
        fatalError("No endpoint found")
    }

    func manhattanDistance(a: Point, b: Point) -> Int {
        return abs(a.x - b.x) + abs(a.y - b.y)
    }
    func makeFullMap(from initial: [Point: Int], size: Int) -> [Point: Int] {
        var res: [Point: Int] = initial
        for x in 0..<5 {
            for y in 0..<5 {
                if x == 0 && y == 0 {
                    continue
                }
                for point in initial {
                    let newPoint = Point(x: point.key.x + x * size, y: point.key.y + y * size)
                    var newValue = point.value + x + y
                    if newValue > 9 {
                        newValue = (newValue % 9)
                    }
                    res[newPoint] = newValue
                }
            }
        }
        return res
    }
}

extension Array where Element == String {
    func getDay15Board() -> [Point: Int] {
        var res = [Point: Int]()
        for (y, row) in self.enumerated() where !row.isEmpty {
            for x in 0..<self[0].count {
                let point = Point(x: x, y: y)
                let value = row[row.index(row.startIndex, offsetBy: x)]
                res[point] = Int(String(value))
            }
        }
        return res
    }
}
