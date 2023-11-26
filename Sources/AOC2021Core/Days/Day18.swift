//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 18.12.21.
//

import Foundation
import Algorithms

class Day18: Day {
    let input: [String]

    init() throws {
        let input = try InputGetter.getInput(for: 18, part: .first)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }

        self.input = input
    }

    func runPart1() throws {
        let sum = sum(rows: input)
        let res = magnitude(row: sum)
        print("Day18 part1: \(res)")
    }

    func runPart2() throws {
        let res = getMaxPossible(in: input)
        print("Day18 part2: \(res)")
    }

    func magnitude(row: String) -> (result: Int, width: Int) {
        var curr = row
        var matches = curr.matchesAndRange(for: "\\[(\\d+)\\,(\\d+)\\]")
        while matches.count > 0 {
            let str = matches[0].0
            let split = str[str.index(after: str.startIndex)..<str.index(before: str.endIndex)].components(separatedBy: ",")
            assert(split.count == 2)
            let first = Int(split[0])!
            let second = Int(split[1])!
            let newNumber = 3 * first + 2 * second
            let range = matches[0].1
            let start = "\(curr[..<range.lowerBound])\(newNumber)"
            curr = "\(curr[..<range.lowerBound])\(newNumber)\(curr[range.upperBound...])"
            matches = curr.matchesAndRange(for: "\\[(\\d+)\\,(\\d+)\\]")
        }
        return (Int(curr)!, 0)
    }

    func sum(rows: [String]) -> String {
        var curr = rows[0]
        for row in rows[1...] {
            curr = add(first: curr, second: row)
        }
        return curr
    }

    func add(first: String, second: String) -> String {
        let temp = "[\(first),\(second)]"
        var reduced = reduce(string: temp)
        while reduced.1 {
            reduced = reduce(string: reduced.0)
        }
        return reduced.0
    }

    func reduce(string: String) -> (String, Bool) {
        let (afterExplosion, hasExploded) = explode(string: string)
        if hasExploded {
            return (afterExplosion, true)
        }
        let (afterCut, hasCut) = split(string: afterExplosion)
        if hasCut {
            return (afterCut, true)
        }
        return (string, false)
    }

    func split(string: String) -> (String, Bool) {
        for (i, char) in string.dropLast().enumerated() {
            if char.isNumber && string[string.i(offset: i + 1)].isNumber {
                let endIndex = string[string.i(offset: i)...].firstIndex { !$0.isNumber }!

                let number = Int(string[string.i(offset: i)..<endIndex])!
                let firstNumber = number / 2
                let secondNumber = Int(Double(number) / 2 + 0.5)
                let res = "\(string[..<string.i(offset: i)])[\(firstNumber),\(secondNumber)]\(string[endIndex...])"
                return (res, true)
            }
        }
        return ("", false)
    }

    func explode(string: String) -> (String, Bool) {
        // explode
        var openCount: Int = 0
        for (i, char) in string.enumerated() {
            var res = ""
            if char == "[" {
                openCount += 1
                continue
            }
            if char == "]" {
                openCount -= 1
                continue
            }
            if char.isNumber && openCount >= 5 {
                let si = string.i(offset: i)
                let sub = string[si...]
                if let nextIndex = sub.firstIndex(of: ",") {
                    let number = Int(String(string[si..<nextIndex]))!
                    // if it's only a value and not a pair
                    if !string[string.index(after: nextIndex)].isNumber {
                        continue
                    }
                    let endIndex = sub.firstIndex { $0 == "[" || $0 == "]"}!
                    let second = Int(String(string[string.index(after: nextIndex)..<endIndex]))!
//                    print(number)
//                    print(second)

                    // add to left
                    var leftI = si
                    var numberStopIndex: String.Index?
                    var numberStartIndex: String.Index?
                    while leftI > string.startIndex {
                        leftI = string.index(before: leftI)
                        if string[leftI].isNumber && numberStopIndex == nil {
                            numberStopIndex = leftI
                        } else if numberStopIndex != nil && !string[leftI].isNumber {
                            numberStartIndex = string.index(after: leftI)
                        }
                        if numberStartIndex != nil && numberStopIndex != nil {
                            break
                        }
                    }
                    if let start = numberStartIndex, let stop = numberStopIndex {
                        let numberToAdd = Int(string[start...stop])!
                        let newNumber = numberToAdd + number
                        res = "\(string[..<start])\(newNumber)\(string[string.index(after: stop)..<string.index(before: si)])"
                    } else {
                        // using index before, to remove bracket
                        res = "\(string[..<string.index(before: si)])"
                    }

                    res.append("0")
                    // add to right
                    if let rightStartIndex: String.Index = string[endIndex...].firstIndex(where: { $0.isNumber }) {
                        let rightEnd = string[rightStartIndex...].firstIndex { !$0.isNumber }!
                        let rightToAdd = Int(string[rightStartIndex..<rightEnd])!
//                        print(rightToAdd)
                        let newNumber = rightToAdd + second
                        res.append("\(string[string.index(after: endIndex)..<rightStartIndex])\(newNumber)\(string[ rightEnd...])")
                    } else {
                        // using index after, to remove bracket
                        res.append("\(string[string.index(after: endIndex)...])")
                    }
                    return (res, true)
                }
            }
        }
        return (string, false)
    }

    func getMaxPossible(in rows: [String]) -> Int {
        var max = 0
        rows
            .permutations(ofCount: 2)
            .map { $0 }
            .forEach {
                let sum = self.sum(rows: $0)
                let res = self.magnitude(row: sum)
                if res.result > max {
                    max = res.result
                }
            }

        return max
    }
}

extension String {
    func i(offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
}
