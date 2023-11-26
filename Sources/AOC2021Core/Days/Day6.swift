//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 06.12.21.
//

import Foundation

class Day6: Day {
    let input: [Int]

    init() throws {
        let input = try InputGetter.getInput(for: 6, part: .first)
            .matches(for: "(\\d+)")
            .compactMap { Int($0) }

        self.input = input
    }
    
    func runPart1() throws {
        let res = getAmountAfter(days: 80, initial: input)
        print("result day 1 part 1: \(res)")
    }

    func runPart2() throws {
        let res = getAmountAfter(days: 256, initial: input)
        print("result day 1 part 2: \(res)")
    }

    func getAmountAfter(days: Int, initial: [Int]) -> Int {
        let start = CFAbsoluteTimeGetCurrent()
        let res = initial.population(after: days)

        let end = CFAbsoluteTimeGetCurrent()
        // to beat: 1.6 s
        print("took: \(end - start)")
        return res

    }
}

private extension Array where Element == Int {
    func population(after: Int) -> Int {
        let mappedItems = self.map { ($0 + 1, 1) }
        var counts = Dictionary(mappedItems, uniquingKeysWith: +)

        var day = 0
        while day < after {
            let nextBreed = counts.keys.min()!
            let fishBreeding = counts[nextBreed]!
            day += nextBreed
            counts[nextBreed] = nil
            counts = Dictionary(uniqueKeysWithValues: counts.map({ key, value in
                (key - nextBreed, value)
            }))
            counts[7, default: 0] += fishBreeding
            counts[9, default: 0] += fishBreeding
        }

        print(counts)

        return counts.reduce(0) { res, curr in
            res + curr.value
        }
    }
}
