//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 12.12.21.
//

import Foundation

class Cave {
    var name: String
    var neighbors: [Cave] = []

    let canBeVisitedMultipleTimes: Bool

    init(name: String) {
        self.name = name
        canBeVisitedMultipleTimes = "A"..."Z" ~= name.first!
    }
}

extension Cave: CustomStringConvertible {
    var description: String {
        let n = neighbors
            .map(\.name)
            .joined(separator: ", ")

        return "\(name): \(n)"
    }
}

extension Cave: Hashable {
    static func == (lhs: Cave, rhs: Cave) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class Day12: Day {
    let input: [String: Cave]

    init() throws {
        let input = try InputGetter.getInput(for: 12, part: .first)
            .components(separatedBy: "\n")
            .getDay12Caves()

        self.input = input
    }

    init(input: [String: Cave]) {
        self.input = input
    }

    func runPart1() throws {
        let res = getNumberOfPathsToEnd(input: input, canVisitTwice: false)
        print("Day12 part1: \(res)")
    }

    func runPart2() throws {
        let start = CFAbsoluteTimeGetCurrent()
        let res = recursiveFindTwice(partial: ([], input["start"]!, false))
        let end = CFAbsoluteTimeGetCurrent()
        print("Day12 part2: \(res)")
        print("took: \(end - start)")

        print("t: \(t)")
    }

    func getNumberOfPathsToEnd(input: [String: Cave], canVisitTwice: Bool) -> Int {
        return canVisitTwice ? findPath(in: input).count : findPath(in: input).count
    }

    func findPath(in input: [String: Cave]) -> Set<[Cave]> {
        guard let current = input["start"] else {
            fatalError("start not found")
        }
        var found = Set<[Cave]>()
        var partial: [[Cave]] = current.neighbors.map { [current, $0] }
        while !(partial.filter { $0.last!.name != "end" }.isEmpty) {
            var newValues: [[Cave]] = []
            for p in partial {
                let allNextSteps = p.last!.neighbors.filter {
                    if !p.contains($0) {
                        return true
                    } else {
                        return $0.canBeVisitedMultipleTimes
                    }
                }
                if allNextSteps.isEmpty {
                    continue
                }
                for next in allNextSteps {
                    if next.name == "end" {
                        found.insert(p + [next])
                    } else {
                        newValues.append(p + [next])
                    }
                }
            }
            partial = newValues
        }
        return found
    }

    func recursiveFind(input: [String: Cave], partial: [Cave]) -> [[Cave]?] {
        let allNextSteps = partial.last!.neighbors.filter {
            if !partial.contains($0) {
                return true
            } else {
                return $0.canBeVisitedMultipleTimes
            }
        }

        var res = [[Cave]]()
        for next in allNextSteps {
            if next.name == "end" {
                res.append(partial)
            } else {
                let allSubPaths = recursiveFind(input: input, partial: partial + [next])
                    .compactMap { $0 }
                    .map { partial + $0 }
                res.append(contentsOf: allSubPaths)
            }
        }
        return res
    }

    var t: Double = 0
    func recursiveFindTwice(partial: (Set<Cave>, Cave, Bool)) -> Int {
        var res = 0

        var newCaveSet = partial.0
        newCaveSet.insert(partial.1)
        for step in partial.1.neighbors {
            guard step.name != "start" else {
                continue
            }
            guard step.name != "end" else {
                res += 1
                continue
            }
            let start = CFAbsoluteTimeGetCurrent()
            let containsStep = partial.0.contains(step)
            t += CFAbsoluteTimeGetCurrent() - start
            let hasVisitedTwice: Bool

            if !containsStep || step.canBeVisitedMultipleTimes {
                hasVisitedTwice = partial.2
            } else if partial.2 && containsStep {
                continue
            } else if containsStep {
                hasVisitedTwice = true
            } else {
                hasVisitedTwice = false
            }
            res += recursiveFindTwice(partial: (newCaveSet, step, hasVisitedTwice))
        }
        return res
    }

    func findPathVistingTwice(in input: [String: Cave]) -> Set<[Cave]> {
        guard let current = input["start"] else {
            fatalError("start not found")
        }
        var found = Set<[Cave]>()
        var partial: [(caves: [Cave], hasVisitedTwice: Bool)] = current.neighbors.map { ([current, $0], false) }
        while !(partial.filter { $0.caves.last!.name != "end" }.isEmpty) {
            var newValues: [([Cave], Bool)] = []
            for p in partial {
                let allNextSteps = getAllNextSteps(caves: p.caves, hasVisitedTwice: p.hasVisitedTwice)

                if allNextSteps.isEmpty {
                    continue
                }
                for next in allNextSteps {
                    if next.0.name == "end" {
                        found.insert(p.caves + [next.0])
                    } else {
                        newValues.append((p.caves + [next.0], next.1))
                    }
                }
            }
            partial = newValues
        }
        return found
    }

    func getAllNextSteps(caves: [Cave], hasVisitedTwice: Bool) -> [(Cave, Bool)] {
        var allNextSteps: [(Cave, Bool)] = []
        for step in caves.last!.neighbors {
            if step.name == "start" {
                continue
            }
            let containsStep = caves.contains(step)
            if !containsStep || step.canBeVisitedMultipleTimes {
                allNextSteps.append((step, hasVisitedTwice))
            } else if hasVisitedTwice && containsStep {
                continue
            } else if containsStep {
                allNextSteps.append((step, true))
            } else {
                allNextSteps.append((step, false))
            }
        }
        return allNextSteps
    }
}

extension Array where Element == String {
    func getDay12Caves() -> [String: Cave] {
        var caves: [String: Cave] = [:]
        for row in self where !row.isEmpty {
            let elements = row.components(separatedBy: "-")
            assert(elements.count == 2)
            let startCave = caves[elements[0]] ?? Cave(name: elements[0])
            let endCave = caves[elements[1]] ?? Cave(name: elements[1])
            startCave.neighbors.append(endCave)
            endCave.neighbors.append(startCave)
            caves[elements[0]] = startCave
            caves[elements[1]] = endCave
        }
        return caves
    }
}
