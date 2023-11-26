//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 13.12.21.
//

import Foundation

class Day13: Day {
    let input: (board: Set<Point>, instructions: [(Character, Int)])

    init() throws {
        let input = try InputGetter.getInput(for: 13, part: .first)
            .components(separatedBy: "\n")
            .getDay13Data()
        self.input = input
    }

    func runPart1() throws {
        let res = fold(board: input.board, instructions: Array(input.instructions[0..<1]))
        print("Day 13 Part 1: \(res.count)")
    }

    func runPart2() throws {
        let res = fold(board: input.board, instructions: input.instructions)
        let maxX = res.max { $0.x < $1.x }!.x
        let maxY = res.max { $0.y < $1.y }!.y
        for y in 0...maxY {
            for x in 0...maxX {
                print(res.contains(Point(x: x, y: y)) ? "#" : "-", terminator: "")
            }
            print()
        }
        print("Day 13 Part 1: \(res.count)")
    }

    func fold(board: Set<Point>, instructions: [(Character,Int)]) -> Set<Point> {
//        print(board)
//        print(instructions)
        var res: Set<Point> = board
        for instruction in instructions {
            switch instruction.0 {
            case "y":
                res = foldHorizontally(board: res, position: instruction.1)
            case "x":
                res = foldVertically(board: res, position: instruction.1)
            default:
                fatalError("invalid instruction")
            }
        }
        return res
    }

    func foldHorizontally(board: Set<Point>, position: Int) -> Set<Point> {
        assert(position == board.max { $0.y < $1.y }!.y / 2)
        var res: Set<Point> = board
        for point in board {
            guard point.y > position else {
                continue
            }
            let newPoint = Point(x: point.x, y: position - (point.y - position))
            res.remove(point)
            res.insert(newPoint)
        }
        return res
    }

    func foldVertically(board: Set<Point>, position: Int) -> Set<Point> {
        assert(position == board.max { $0.x < $1.x }!.x / 2)
        var res: Set<Point> = board
        for point in board {
            guard point.x > position else {
                continue
            }
            let newPoint = Point(x: position - (point.x - position), y: point.y)
            res.remove(point)
            res.insert(newPoint)
        }
        return res
    }
}

extension Array where Element == String {
    func getDay13Data() -> (board: Set<Point>, instructions: [(Character, Int)]) {
        var points: Set<Point> = []
        var instructions: [(Character, Int)] = []
        for row in self {
            guard !row.isEmpty else { continue }
            let components = row.components(separatedBy: ",")
            if components.count == 2 {
                let x = Int(components[0])!
                let y = Int(components[1])!
                points.insert(Point(x: x, y: y))
                continue
            }
            let instructionComponents = row.components(separatedBy: [" ", "="])
            guard
                instructionComponents.count == 4 else {
                fatalError("invalid input")
            }
            instructions.append((instructionComponents[2].first!, Int(instructionComponents[3])!))
        }
        return (points, instructions)
    }
}
