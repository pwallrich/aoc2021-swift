//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 21.12.21.
//

import Foundation

class Day21: Day {
    struct Game: Hashable {
        var positions: [Int]
        var scores: [Int]
        var currPlayerIndex: Int
    }
    let input = (7, 1)

    func runPart1() throws {
        let res = deterministicRolll(input: input)
        print("Day 21 part1: \(res)")
    }

    func runPart2() throws {
        let res = rollWithSplitting(input: input)
        print("Day 21 part2: \(res)")
    }

    func deterministicRolll(input: (Int, Int)) -> Int {
        var positions = [input.0, input.1]

        var res =  Array(repeating: 0, count: 2)
        var d = 1

        var turnIndex = 0
        while (res.filter { $0 >= 1000 }).isEmpty {
            let move = 3 * d + 3
            // advance

            let v = getNextIndex(curr: positions[turnIndex], value: move)
            positions[turnIndex] = v

            res[turnIndex] += v

            turnIndex = (turnIndex + 1) % 2
            d += 3
        }

        return (d - 1) * res.min()!
    }

    func getNextIndex(curr: Int, value: Int) -> Int {
        var v = curr
        let toAdvance = value % 10
        v += toAdvance
        if v > 10 {
            v -= 10
        }
        return v
    }

    func rollWithSplitting(input: (Int, Int)) -> Double {
        // roll dice
        let game = Game(positions: [input.0, input.1], scores: [0,0], currPlayerIndex: 0)
        let r = play(game: game, currScores: (0, 0))
        return max(r.p1, r.p2)
    }

    var results: [Game: (Double, Double)] = [:]

    func play(game: Game, currScores: (Double, Double)) -> (p1: Double, p2: Double) {
        if let r = results[game] {
            return r
        }
        var res: (Double, Double) = (0,0)
        for i1 in 1...3 {
            for i2 in 1...3 {
                for i3 in 1...3 {
                    var positions = game.positions
                    var newPosition = positions[game.currPlayerIndex] + i1 + i2 + i3
                    while newPosition > 10 {
                        newPosition -= 10
                    }
                    positions[game.currPlayerIndex] = newPosition
                    var scores = game.scores
                    let newScore = scores[game.currPlayerIndex] + newPosition
                    if newScore >= 21 {
                        if game.currPlayerIndex == 0 {
                            res.0 += 1
                        } else {
                            res.1 += 1
                        }
                    } else {
                        scores[game.currPlayerIndex] = newScore
                        let tRes = play(game: Game(positions: positions, scores: scores, currPlayerIndex: (game.currPlayerIndex + 1) % 2), currScores: res)
                        res.0 += tRes.p1
                        res.1 += tRes.p2
                    }

                }
            }
        }
        results[game] = res
        return res
    }
}
