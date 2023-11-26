//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 22.12.21.
//

import Foundation
import simd

class Day22: Day {
    let input: [String]

    init() throws {
        let input = try InputGetter.getInput(for: 22, part: .first)
            .components(separatedBy: "\n")

        self.input = input
    }

    func runPart1() throws {
        let res = initializeCube(input: input, shouldFilter: true)
        print("Day 22 Part1: \(res)")
    }

    func runPart2() throws {
        let res = initializeCube(input: input, shouldFilter: false)
        print("Day 22 Part2: \(res)")
    }

    struct Shape: Hashable {
        let xRange: ClosedRange<Int>
        let yRange: ClosedRange<Int>
        let zRange: ClosedRange<Int>

        var itemCount: Int {
            return xRange.count * yRange.count * zRange.count
        }

        func intersectingItemCount(with other: Shape) -> Int {
            return intersectingItems(with: other)?.itemCount ?? 0
        }

        func intersectingItems(with other: Shape) -> Shape? {
            guard xRange.overlaps(other.xRange) && yRange.overlaps(other.yRange) && zRange.overlaps(other.zRange) else {
                return nil
            }
            let xRangeOverlap: ClosedRange<Int> = {
                let lower = max(xRange.lowerBound, other.xRange.lowerBound)
                let upper = min(xRange.upperBound, other.xRange.upperBound)
                return lower...upper
            }()
            let yRangeOverlap: ClosedRange<Int> = {
                let lower = max(yRange.lowerBound, other.yRange.lowerBound)
                let upper = min(yRange.upperBound, other.yRange.upperBound)
                return lower...upper

            }()
            let zRangeOverlap: ClosedRange<Int> = {
                let lower = max(zRange.lowerBound, other.zRange.lowerBound)
                let upper = min(zRange.upperBound, other.zRange.upperBound)
                return lower...upper
            }()
            return Shape(xRange: xRangeOverlap, yRange: yRangeOverlap, zRange: zRangeOverlap)
        }
    }

    func initializeCube(input: [String], shouldFilter: Bool) -> Int {
        var calculations: [(shape: Shape, isPositive: Bool)] = []

        for row in input where !row.isEmpty {
            let ranges = row
                .matches(for: "(-?\\d+)")
                .compactMap { Int($0) }
            assert(ranges.count == 6)

            let xRange = ranges[0]...ranges[1]
            let yRange = ranges[2]...ranges[3]
            let zRange = ranges[4]...ranges[5]

            if shouldFilter {
                guard xRange.overlaps(-50...50) && yRange.overlaps(-50...50) && zRange.overlaps(-50...50) else {
                    continue
                }
            }
            let shape = Shape(xRange: xRange, yRange: yRange, zRange: zRange)
            for (c2, c2IsPositive) in calculations {
                if let intersect = shape.intersectingItems(with: c2) {
                    calculations.append((intersect, !c2IsPositive))
                }
            }
            if row.starts(with: "on") {
                calculations.append((shape, true))
            }
        }

        var res = 0
        // calculate res
        for (cube, isPositive) in calculations {
            if isPositive {
                res += cube.itemCount
            } else {
                res -= cube.itemCount
            }
        }

        return res
    }

    struct Instruction {
        enum Operation {
            case on, off
        }
        let operation: Operation
        let xRange: Range<Int>
        let yRange: Range<Int>
        let zRange: Range<Int>
    }
}

