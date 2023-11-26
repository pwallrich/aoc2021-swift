//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 11.12.21.
//

import Foundation

class Day11: Day {
    let input: [String]

    init() throws {
        let input = try InputGetter.getInput(for: 11, part: .first)
            .components(separatedBy: "\n")

        self.input = input.dropLast()
    }
    func runPart1() throws {
        let res = getNumberOfFlashes(until: 100, input: input)
        print("Day11 part 1: \(res)")
    }

    func runPart2() throws {
        let res = getStepWhenAllSynced(input: input)
        print("Day11 part 2: \(res)")
    }

    func getNumberOfFlashes(until steps: Int, input: [String]) -> Int {
        var board = input.getDictOfGrid()
        var res = 0
        for i in 0..<steps {
            let (newBoard, flashes) = advanceOneStep(board: board)
            board = newBoard
            res += flashes
            if i % 10 == 0 {
                print("did step \(i): res: \(res)")
            }
        }
        return res
    }

    func getStepWhenAllSynced(input: [String]) -> Int {
        var board = input.getDictOfGrid()
        var flashed = 0
        var count = 0
        while flashed < board.count {
            (board, flashed) = advanceOneStep(board: board)
            count += 1
        }
        return count
    }

    func advanceOneStep(board: [Point: Int]) -> (board: [Point: Int], flashes: Int) {
        var flashes = 0
        var hasFlashed: Set<Point> = []
        // increase the eneregy by 1
        var newBoard = board.mapValues { $0 + 1 }
        while true {
            let toFlash = newBoard.filter { $0.value > 9 && !hasFlashed.contains($0.key)}
            if toFlash.count == 0 {
                break
            }
            for var (point, value) in toFlash {
//                print("flashing: \(point) with value \(value)")
                if value >= 9 {
                    newBoard[point] = 0
                    flashes += 1
                    hasFlashed.insert(point)

                    let increasedNeighbors = increaseNeighbors(of: point, in: newBoard)
                    for n in increasedNeighbors {
                        newBoard[n.0] = n.1
                    }
                }
            }
        }
        return (newBoard, flashes)
    }

    func increaseNeighbors(of point: Point, in board: [Point: Int]) -> [(Point, Int)] {
        var res: [(Point, Int)] = []
        for offset in [(-1,-1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1) ] {
            let newPoint = Point(x: point.x + offset.0, y: point.y + offset.1)
            guard let value = board[newPoint], value > 0 else {
                continue
            }
//            print("increasing neighbor: \(newPoint) having value: \(value)")
            res.append((newPoint, value + 1))
        }
        return res
    }
}
