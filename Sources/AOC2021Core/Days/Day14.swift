//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 14.12.21.
//

import Foundation
import Algorithms

class Day14: Day {
    let input: (element: String, mapping: [String: Character])

    init(input: (element: String, mapping: [String: Character])) {
        self.input = input
    }

    init() throws {
        let input = try InputGetter.getInput(for: 14, part: .first)
            .components(separatedBy: "\n")
            .getDay14Data()

        self.input = input
    }

    func runPart1() throws {
        let res = getMinMaxDiff(element: input.element, mapping: input.mapping)
        print("Day14 part1: \(res)")
    }

    func runPart2() throws {
        let start = CFAbsoluteTimeGetCurrent()
        let res = getMinMaxDiff(element: input.element, mapping: input.mapping, stepCount: 40)
        let end = CFAbsoluteTimeGetCurrent()
        print("Day14 part2: \(res)")
        print("took: \(end - start)")
    }

    func getMinMaxDiff(element: String, mapping: [String: Character], stepCount: Int = 10) -> Int {
        let counts = getCharCount(element: element, mapping: mapping, stepCount: stepCount)
        let min = counts.min { $0.value < $1.value }!
        let max = counts.max { $0.value < $1.value }!
        return max.value - min.value
    }

    func getCharCount(element: String, mapping: [String: Character], stepCount: Int = 10) -> [Character: Int] {
        let resElement = element

        var counts = [Character: Int]()
        for pair in resElement.windows(ofCount: 2) {
            for element in getCharCounts(input: String(pair), steps: stepCount) {
                counts[element.key, default: 0] += element.value
            }
        }


        for c in resElement {
            counts[c, default: 0] += 1
        }

        print(counts)
        return counts
    }

    struct RecKey: Hashable {
        let input: String
        let steps: Int
    }

    var cache: [RecKey: [Character: Int]] = [:]

    func getCharCounts(input: String, steps: Int) -> [Character: Int] {
        if steps == 1 {
            return [self.input.mapping[input]!: 1]
        }
        if let value = cache[RecKey(input: input, steps: steps)] {
            return value
        }
        let toInsert = self.input.mapping[input]!
        var dict = getCharCounts(input: "\(input.first!)\(toInsert)", steps: steps - 1)
        let secondDict = getCharCounts(input: "\(toInsert)\(input.last!)", steps: steps - 1)
        for e in secondDict {
            dict[e.key, default: 0] += e.value
        }
        dict[toInsert, default: 0] += 1
        cache[RecKey(input: input, steps: steps)] = dict
        return dict
    }
}

extension Array where Element == String {
    func getDay14Data() -> (element: String, mapping: [String: Character]) {
        let element  = self[0]
        var res: [String: Character] = [:]
        for row in self.dropFirst() where !row.isEmpty {
            let components = row.components(separatedBy: " -> ")
            assert(components.count == 2)
            assert(components[1].count == 1)
            res[components[0]] = components[1].first!
        }

        return (element, res)
    }
}
