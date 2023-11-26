//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 08.12.21.
//

import Foundation

class Day8: Day {
    typealias Input = (input: [String], output: [String])
    let input: [Input]
    let validInputs: Set<Character> = Set("abcdefg")

    init(text: String) {
        let lines = text
            .components(separatedBy: "\n")
        self.input = lines.splitInputAndOutput()
    }

    convenience init() throws {
        let lines = try InputGetter.getInput(for: 8, part: .first)

        self.init(text: lines)
    }
    
    func runPart1() throws {
        let res = countOneFourSevenAndEightInOutputs(input: input)
        print("Day8 Part1: \(res)")
    }

    func runPart2() throws {
        let res = calculateValue(input: input)
        print("Day8 Part2: \(res)")
    }

    func countOneFourSevenAndEightInOutputs(input: [Input]) -> Int {
        print(input.count)
        let res = input
            .reduce(0) { res, curr in
                res + curr.output.filter({ word in
                    let charCount = word.count
                    print("\(word): \(charCount)")
                    return charCount == 2 // 1
                        || charCount == 3 // 7
                        || charCount == 4 // 4
                        || charCount == 7 // 8
                }).count
            }
        return res
    }

    func calculateValue(input: [Input]) -> Int {
        let res = input.reduce(0) { res, curr in
            guard !curr.output.isEmpty else { return res }
            let value = getRowValue(input: curr)
            return value + res
        }
        return res
    }

    func getRowValue(input: Input) -> Int {
        let values = getInputNumberMapping(input: input)
        var res = 0
        for (i, word) in input.output.reversed().enumerated() {
            res += values[Set(word)]! * Int(pow(10.0, Double(i)))
        }
        return res
    }

    func getInputNumberMapping(input: Input) -> [Set<Character>: Int] {
        let sortedBySize = input.input
            .sorted { $0.count < $1.count }
            .map { Set($0) }


        let mappedValues = input.input.map { value -> (Set<Character>, Int) in
            let set = Set(value)
            let intersectionWithOne = set.intersection(sortedBySize[0])
            let intersectionWithFour = set.intersection(sortedBySize[2])
            switch (value.count, intersectionWithOne.count, intersectionWithFour.count)  {
            case (2, _, _): return (set, 1)
            case (3, _, _): return (set, 7)
            case (4, _, _): return (set, 4)
            case (7, _, _): return (set, 8)
            case (6, 2, 3): return (set, 0)
            case (6, 1, 3): return (set, 6)
            case (6, 2, 4): return (set, 9)
            case (5, 1, 2): return (set, 2)
            case (5, 2, 3): return (set, 3)
            case (5, 1, 3): return (set, 5)
            default:
                fatalError("shouldn't happen")
            }
        }

        return Dictionary(uniqueKeysWithValues: mappedValues)

    }

    func getInputNumberMapping(input: [Input]) -> [Set<Character>: Int] {
        var numbers: [Int: Set<Character>] = [:]
        var values: [Set<Character>: Int] = [:]
        var segments: [Character?] = Array(repeating: nil, count: 7)

        let uniqueWords = input.reduce(Set<Set<Character>>()) { res, curr in
            var new = res
            (curr.output).forEach { new.insert(Set($0)) }

            return new
        }

        assert(uniqueWords.count == 10)
        var remaining = uniqueWords
        for word in uniqueWords {
            if word.count == 2 {
                values[word] = 1
                numbers[1] = word
                remaining.remove(word)
            } else if word.count == 3 {
                values[word] = 7
                numbers[7] = word
                remaining.remove(word)
            } else if word.count == 4 {
                values[word] = 4
                numbers[4] = word
                remaining.remove(word)
            } else if word.count == 7 {
                values[word] = 8
                numbers[8] = word
                remaining.remove(word)
            }
        }

        segments[0] = find0thSegment(input: numbers)

        var commonInAllNotKnown = findCommonInNotKnwon(input: uniqueWords)
        commonInAllNotKnown.remove(segments[0]!)
        assert(commonInAllNotKnown.count == 1)
        segments[6] = commonInAllNotKnown.first!

        // find 9
        for word in uniqueWords {
            guard word.count == 6 else { continue }
            var oneAndSevenAndFour = numbers[4]!
                .symmetricDifference(numbers[1]!)
                .symmetricDifference(numbers[7]!)
            oneAndSevenAndFour.insert(segments[6]!)
            if Set(word).subtracting(oneAndSevenAndFour).count == 0 {
                values[word] = 9
                numbers[9] = word
                remaining.remove(word)
                let fifth = validInputs.subtracting(word)
                assert(fifth.count == 1)
                segments[5] = fifth.first!
            }
        }


        // find 0
        let sixAndZero = remaining
            .filter { $0.count == 6 }

        let zeroArr = sixAndZero
            .filter { numbers[1]!.intersection($0).count == 2 }

        assert(zeroArr.count == 1)
        values[zeroArr.first!] = 0
        numbers[0] = zeroArr.first!
        remaining.remove(zeroArr.first!)

        // find 6
        let sixArr = sixAndZero.filter { $0 != numbers[0]! }
        assert(sixArr.count == 1)
        values[sixArr.first!] = 6
        numbers[6] = sixArr.first!
        remaining.remove(sixArr.first!)

        // find 5
        let fiveArr = remaining.filter {
            $0.subtracting(numbers[6]!).count == 0
        }
        assert(fiveArr.count == 1)
        values[fiveArr.first!] = 5
        numbers[5] = fiveArr.first!
        remaining.remove(fiveArr.first!)

        // find 3
        let threeArr = remaining.filter {
            numbers[1]!.subtracting($0).count == 0
        }
        assert(threeArr.count == 1)
        values[threeArr.first!] = 3
        numbers[3] = threeArr.first!
        remaining.remove(threeArr.first!)

        assert(remaining.count == 1)
        values[remaining.first!] = 2
        numbers[2] = remaining.first!
        return values
    }

    func find0thSegment(input: [Int: Set<Character>]) -> Character {
        let seven = input[7]!
        let one = input[1]!

        let res = Set(seven).subtracting(Set(one))
        assert(res.count == 1)
        return res.first!
    }


    func findCommonInNotKnwon(input: Set<Set<Character>>) -> Set<Character> {
        // find 8th segment
        input
            .filter {
                let charCount = $0.count
                return !(charCount == 2 // 1
                       || charCount == 3 // 7
                       || charCount == 4 // 4
                       || charCount == 7)
            }
            .reduce(validInputs) {
                $0.intersection($1)
            }
    }
}

extension Array where Element == String {
    func splitInputAndOutput() -> [(input: [String], output: [String])] {
        var input: [(input: [String], output: [String])] = []
        for line in self {
            var inString: [String] = []
            var outString: [String] = []
            var hasSeenSeparator = false
            let words = line.components(separatedBy: .whitespaces)
            for word in words {
                if word == "|" {
                    hasSeenSeparator = true
                    continue
                }
                if hasSeenSeparator {
                    outString.append(word)
                } else {
                    inString.append(word)
                }
            }
            input.append((inString, outString))
        }
        return input
    }
}
