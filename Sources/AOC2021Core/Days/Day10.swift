//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 10.12.21.
//

import Foundation

class Day10: Day {
    let input: [String]

    init() throws {
        let input = try InputGetter.getInput(for: 10, part: .first)
            .components(separatedBy: "\n")

        self.input = input.dropLast()
    }

    func runPart1() throws {
        let res = getIncorrectLineScore(in: input)
        print("Day 10 part 1: \(res)")
    }

    func runPart2() throws {
        let res = getMiddleScore(in: input)
        print("Day 10 part 2: \(res)")
    }

    func getIncorrectLineScore(in input: [String]) -> Int {
        let openBrackets: [Character] = ["[", "(", "<", "{"]
        let closeBrackets: [Character] = ["]", ")", ">", "}"]

        let scores: [Character: Int] = [
            "]": 57,
            ")": 3,
            ">": 25137,
            "}": 1197
        ]

        var res = 0

        for line in input {
            var toClose = [(Character, Int)]()
            for char in line {
                if let index = openBrackets.firstIndex(of: char) {
                    toClose.append((char, index))
                } else if let index = closeBrackets.firstIndex(of: char) {
                    guard let last = toClose.popLast() else {
                        print("first char was close char")
                        break
                    }
                    guard
                        index == last.1
                    else {
                        res += scores[char]!
                        break
                    }
                } else {
                    fatalError("unsupported character")
                }
            }
        }

        return res
    }

    func getMiddleScore(in input: [String]) -> Int {
        let res = getScoresFor(input: input)
            .sorted(by: <)
        return res[res.count/2]
    }

    func getScoresFor(input: [String]) -> [Int] {
        let scores: [Character: Int] = [
            "]": 2,
            ")": 1,
            ">": 4,
            "}": 3
        ]
        return input
            .compactMap(getClosingString(input:))
            .map {
                $0.reduce(0) { $0 * 5 + scores[$1]! }
            }
    }

    func getClosingString(input: String) -> String? {
        let openBrackets: [Character] = ["[", "(", "<", "{"]
        let closeBrackets: [Character] = ["]", ")", ">", "}"]

        var toClose = [(Character, Int)]()
        for char in input {
            if let index = openBrackets.firstIndex(of: char) {
                toClose.append((char, index))
            } else if let index = closeBrackets.firstIndex(of: char) {
                guard let last = toClose.popLast() else {
                    print("first char was close char")
                    break
                }
                guard
                    index == last.1
                else {
                    return nil
                }
            } else {
                fatalError("unsupported character")
            }
        }
        let closingString = toClose.reversed().reduce("") { res, curr in
            "\(res)\(closeBrackets[curr.1])"
        }
        return closingString
    }
}
