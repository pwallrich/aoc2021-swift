//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 07.12.21.
//

import Foundation

class Day7: Day {
    let input: [Int]

    init() throws {
        let input = try InputGetter.getInput(for: 7, part: .first)
            .matches(for: "(\\d+)")
            .compactMap { Int($0) }

        self.input = input
    }

    func runPart1() throws {
        let res = getPointWithMinFuel(initial: input, calculate: calculateFuel(for:initial:))
        print("Day7 part1: \(res!)")
    }

    func runPart2() throws {
        let start = CFAbsoluteTimeGetCurrent()
        let res = getFuelPart2(initial: input)
        let end = CFAbsoluteTimeGetCurrent()
        print("Day7 part2: \(res)")
        print("took: \(end - start)")
    }

    func getPointWithMinFuel(initial: [Int], calculate: (Int, [Int]) -> Int) -> (point: Int, fuel: Int)? {
        let median = initial.sorted(by: <)[initial.count / 2]
        return (median, calculateFuel(for: median, initial: initial))
    }

    func getFuelPart2(initial: [Int]) -> Int {
        let average = initial.reduce(0, +) / initial.count
        let lower = calculateFuelIncreasing(for: average, initial: initial)
        let upper = calculateFuelIncreasing(for: average + 1, initial: initial)
        return min(lower, upper)
    }

    func calculateFuel(for value: Int, initial: [Int]) -> Int {
        return initial.reduce(0) { res, curr in
            return res + abs(curr - value)
        }
    }

    func calculateFuelIncreasing(for value: Int, initial: [Int]) -> Int {
        return initial.reduce(0) { res, curr in
            let absolute = abs(curr - value)
            let dreieck = absolute * (absolute + 1) / 2
            return res + dreieck
        }
    }
}
