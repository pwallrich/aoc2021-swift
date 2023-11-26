//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 01.12.21.
//

import Foundation

class Day1: Day {
    var day: Int { 1 }
    let input: [Int]

    init() throws {
        let input = try InputGetter.getInput(for: 1, part: .first)
            .components(separatedBy: "\n")
            .compactMap { Int($0) }

        self.input = input
    }

    func runPart1() throws {
        let result = zip(input, input.dropFirst())
            .filter { $1 > $0 }

        print("result is \(result.count)")
    }

    func runPart2() throws {
        let res = input
            .window(of: 3)
            .map { $0.reduce(0, +) }
            .window(of: 2)
            // ArraySlice is not 0 based, but using idx of original array
            .filter { $0[$0.endIndex - 1] > $0[$0.startIndex] }

        print("result is \(res.count)")
    }
}

private extension Array where Element == Int {
    func countIncreasing() -> Int {
        reduce((nil, 0)) { (res: (Int?, Int), current: Int) in
            if let last = res.0, current > last {
                return (current, res.1 + 1)
            }
            return (current, res.1)
        }.1
    }
}

private extension Collection {
    func window(of n: Int) -> [SubSequence] {
        indices.dropLast(n-1).map {
            self[$0..<(index($0, offsetBy: n, limitedBy: self.endIndex) ?? self.endIndex)]
        }
    }
}
