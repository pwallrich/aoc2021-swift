//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 09.12.21.
//

import Foundation

class Day9: Day {
    let input: [String]

    init() throws {
        let input = try InputGetter.getInput(for: 9, part: .first)
            .components(separatedBy: "\n")

        self.input = input
    }

    func runPart1() throws {
        let res = getRiskLevelOfLowPoints(in: input)
        print("Day9 Part1: \(res)")
    }

    func runPart2() throws {
        let res = getBaisinsValue(in: input)
        print("Day9 Part2: \(res)")
    }

    func getRiskLevelOfLowPoints(in input: [String]) -> Int {
        let map = input.getDictOfGrid()
        var res = [Int]()
        for item in map {
            var isLowest = true
            for offset in [(-1, 0), (0, -1), (1, 0), (0, 1)] {
                let p = Point(x: item.key.x + offset.0, y: item.key.y + offset.1)
                guard let p = map[p] else { continue }
                if p <= item.value {
                    isLowest = false
                    break
                }
            }
            if isLowest {
                res.append(item.value)
            }
        }
        return res.reduce(0, +) + res.count
    }

    func getBaisinsValue(in input: [String]) -> Int {
        let map = input.getDictOfGrid()
        let baisins = getBaisins(in: map)
        let biggest = baisins.sorted(by: { $0.count > $1.count })
        return biggest[0..<3].reduce(1) { res, curr in
            res * curr.count
        }

    }

    func getBaisins(in board: [Point: Int]) -> [[Int]] {
        var board = board
        var res: [[Int]] = [[]]
        while (board.filter { $0.value != 9 }).count > 0 {
            let startPoint = board.first { $0.value < 9 }!
            let points = getSorroundingPoints(of: startPoint.key, in: board, alreadySeen: [:])
            var baisin: [Int] = []
            for p in points {
                baisin.append(p.value)
                board[p.key] = nil
            }
            res.append(baisin)
        }
        return res
    }

    func getSorroundingPoints(of point: Point, in board: [Point: Int], alreadySeen: [Point: Int]) -> [Point: Int] {
        var res = alreadySeen
        print("getting neighbors of \(point)")
        for offset in [(-1, 0), (0, -1), (1, 0), (0, 1)] {
            let p = Point(x: point.x + offset.0, y: point.y + offset.1)
            guard
                res[p] == nil,
                let value = board[p],
                value < 9
            else { continue }
            res[p] = value
            res = getSorroundingPoints(of: p, in: board, alreadySeen: res)
        }
        return res
    }
}

extension Array where Element == String {
    func getDictOfGrid() -> [Point: Int] {
        var res = [Point: Int]()
        for (x, row) in self.enumerated() {
            for(y, item) in row.enumerated() {
                res[.init(x: x, y: y)] = Int(String(item))
            }
        }
        return res
    }
}
