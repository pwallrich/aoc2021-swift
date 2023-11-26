//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 25.12.21.
//

import Foundation

class Day25: Day {
    private let input: (dim: (x: Int, y: Int), board: [Point: Character])

    init() throws {
        self.input = try InputGetter.getInput(for: 25, part: .first)
            .components(separatedBy: "\n")
            .getDay25Input()
    }

    func runPart1() throws {
        let res = countUntilNoMovement(on: input.board, dim: input.dim)
        print("Day 25 part1: \(res)")
    }

    func runPart2() throws {

    }

    func countUntilNoMovement(on board: [Point: Character], dim: (x: Int, y: Int)) -> Int {
        var hasMoved = false
        var count = 0
        var board = board
        repeat {
//            print("move \(count)")
//            debugLog(board: board, dim: dim)
            hasMoved = false
            var toMove: [(old: Point, new: Point)] = []
            for element in board where element.value == ">" {
                let newX = (element.key.x + 1) % (dim.x + 1)
                let next = Point(x: newX , y: element.key.y)
                guard board[next] == nil else {
                    continue
                }
                toMove.append((element.key, next))
            }
            for action in toMove {
                hasMoved = true
                board[action.old] = nil
                board[action.new] = ">"
            }
            toMove = []
            for element in board where element.value == "v" {
                let newY = (element.key.y + 1) % (dim.y + 1)
                let next = Point(x: element.key.x , y: newY)
                guard board[next] == nil else {
                    continue
                }
                toMove.append((element.key, next))
            }
            for action in toMove {
                hasMoved = true
                board[action.old] = nil
                board[action.new] = "v"
            }
            count += 1
        } while hasMoved
        print("last")
        debugLog(board: board, dim: dim)
        return count
    }

    func debugLog(board: [Point: Character], dim: (x: Int, y: Int)) {
        for y in 0...dim.y {
            for x in 0...dim.x {
                print(board[Point(x: x, y: y)] ?? ".", terminator: "")
            }
            print()
        }
        for outlier in board.filter { $0.key.x > dim.x || $0.key.y > dim.y } {
            print("OUTLIER: \(outlier)")
        }
    }
}

extension Array where Element == String {
    func getDay25Input() -> (dim: (x: Int, y: Int), board: [Point: Character]) {
        var board: [Point: Character] = [:]
        var dim: (Int, Int) = (0,0)
        for (y, row) in self.enumerated() where !row.isEmpty {
            for (x, char) in row.enumerated() {
                if char == ">" || char == "v" {
                    board[Point(x: x, y: y)] = char
                }
                dim = (x, dim.1)
            }
            dim = (dim.0, y)
        }
        return (dim, board)
    }
}
