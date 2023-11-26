//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 24.12.21.
//

import Foundation

class Day24: Day {
    let input: [String]

    init() throws {
        let input = try InputGetter.getInput(for: 24, part: .first)
            .components(separatedBy: "\n")

        self.input = input
    }

    func runPart1() throws {
        let res = getLargestValid(with: input)
        print("Day24 part1: \(res)")
    }

    func runPart2() throws {

    }

    func run2(programm: [String], inputs: [Double]) -> [Character: Double]? {
        var res: [Character: Double] = [:]
        var inputIdx = 0
        // if first == 9 -> z is 14 after first iteration
        // if second == 9 -> z is 364 after second
        for row in programm.reversed() where !row.isEmpty {
            let split = row.components(separatedBy: " ")
            assert(split.count == 2 || split.count == 3)
            assert(split[1].count == 1)
            // handle inp instruction
            if split.count == 2 {
                let toUse = split[1].first!
                res[toUse] = inputs[inputIdx]
                inputIdx += 1
                print("got next \(toUse) at \(inputIdx)")
                continue
            }
            let second: Double
            if let val = Double(split[2]) {
                second = val
            } else {
                assert(split[2].count == 1)
                let c = split[2].first!
                second = res[c, default: 0]
            }

            switch split[0] {
            case "add":
                let first = split[1].first!
                let t = res[first, default: 0] + second
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "mul":
                let first = row[row.index(row.startIndex, offsetBy: 4)]
                let t = res[first, default: 0] * second
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "div":
                let first = row[row.index(row.startIndex, offsetBy: 4)]
                guard second != 0 else {
                    print("division by zero")
                    return nil
                }
                assert(second != 0)
                let t = res[first, default: 0] / second
                res[first] = round(t)
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "mod":
                let first = row[row.index(row.startIndex, offsetBy: 4)]

                guard second > 0, res[first, default: 0] >= 0 else {
                    print("invalid mod")
                    return nil
                }
                assert(second != 0)
                assert(res[first, default: 0] >= 0 && second > 0)
                let t = res[first, default: 0].truncatingRemainder(dividingBy: second)
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "eql":
                let first = row[row.index(row.startIndex, offsetBy: 4)]
                let t: Double = res[first, default: 0] == second ? 1 : 0
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            default:
                fatalError("unsupported input")
            }
        }
        return res
    }

    func getInstructions(with input: [String]) -> Double? {
        var result: [String] = []
        var values: [Character: String] = [
            "w": "0",
            "x": "0",
            "y": "0",
            "z": "0"
        ]

        var inputIdx = 0
        for (idx,row) in input.enumerated() where !row.isEmpty {
            print("in row: \(idx)")
            let split = row.components(separatedBy: " ")
            assert(split.count == 2 || split.count == 3)
            assert(split[1].count == 1)
            // handle inp instruction
            if split.count == 2 {
                values["w"] = "i\(inputIdx)"
                inputIdx += 1
                result.append("read in new value : \(values["w"]!)")
                continue
            }

            switch split[0] {
            case "add":
                let first = split[1].first!
                let second: String
                if Double(split[2]) != nil {
                    second = split[2]
                } else {
                    second = values[split[2].first!]!
                }
                let newValue = "(\(values[first]!)) + \(second)"
                result.append("\(first) = \(newValue)")
                values[first]! = newValue
            case "mul":
                let first = split[1].first!
                let second: String
                if Double(split[2]) != nil {
                    second = split[2]
                } else {
                    second = values[split[2].first!]!
                }
                let newValue = "(\(values[first]!)) * \(second)"
                result.append("\(first) = \(newValue)")
                values[first]! = newValue
            case "div":
                let first = split[1].first!
                let second: String
                if Double(split[2]) != nil {
                    second = split[2]
                } else {
                    second = values[split[2].first!]!
                }
                let newValue = "(\(values[first]!)) / \(second)"
                result.append("\(first) = \(newValue)")
                values[first]! = newValue
            case "mod":
                let first = split[1].first!
                let second: String
                if Double(split[2]) != nil {
                    second = split[2]
                } else {
                    second = values[split[2].first!]!
                }
                let newValue = "(\(values[first]!)) % \(second)"
                result.append("\(first) = \(newValue)")
                values[first]! = newValue
            case "eql":
                let first = split[1].first!
                let second: String
                if Double(split[2]) != nil {
                    second = split[2]
                } else {
                    second = values[split[2].first!]!
                }
                let newValue = "(\(values[first]!)) == \(second) ? 1 : 0)"
                result.append("\(first) = \(newValue)")
                values[first]! = newValue
            default:
                fatalError("unsupported input")
            }
        }

        print(result.joined(separator: "\n\n"))
        return nil
    }

    func getLargestValid(with input: [String]) -> Double? {
        for i in (1...9).reversed() {
            print("testing \(i)")
//            let curr = Double(Array(repeating: "\(i)", count: 14).joined(separator: ""))!
            let inputArray = Array(repeating: Double(i), count: 14)
            let result = run(programm: input, inputs: inputArray)
            if let result = result, result["z"] == 0 {
                return Double(inputArray.reduce("") { "\($0)\($1)" } )
            }
        }
        return nil
    }

    func run(programm: [String], inputs: [Double]) -> [Character: Double]? {
        var res: [Character: Double] = [:]
        var inputIdx = 0
        // if first == 9 -> z is 14 after first iteration
        // if second == 9 -> z is 364 after second
        for row in programm where !row.isEmpty {
            let split = row.components(separatedBy: " ")
            assert(split.count == 2 || split.count == 3)
            assert(split[1].count == 1)
            // handle inp instruction
            if split.count == 2 {
                let toUse = split[1].first!
                res[toUse] = inputs[inputIdx]
                inputIdx += 1
                print("got next \(toUse) at \(inputIdx)")
                continue
            }
            let second: Double
            if let val = Double(split[2]) {
                second = val
            } else {
                assert(split[2].count == 1)
                let c = split[2].first!
                second = res[c, default: 0]
            }

            switch split[0] {
            case "add":
                let first = split[1].first!
                let t = res[first, default: 0] + second
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "mul":
                let first = row[row.index(row.startIndex, offsetBy: 4)]
                let t = res[first, default: 0] * second
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "div":
                let first = row[row.index(row.startIndex, offsetBy: 4)]
                guard second != 0 else {
                    print("division by zero")
                    return nil
                }
                assert(second != 0)
                let t = res[first, default: 0] / second
                res[first] = round(t)
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "mod":
                let first = row[row.index(row.startIndex, offsetBy: 4)]

                guard second > 0, res[first, default: 0] >= 0 else {
                    print("invalid mod")
                    return nil
                }
                assert(second != 0)
                assert(res[first, default: 0] >= 0 && second > 0)
                let t = res[first, default: 0].truncatingRemainder(dividingBy: second)
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            case "eql":
                let first = row[row.index(row.startIndex, offsetBy: 4)]
                let t: Double = res[first, default: 0] == second ? 1 : 0
                res[first] = t
                if first == "z" {
                    print("updated z to \(res["z"])")
                }
            default:
                fatalError("unsupported input")
            }
        }
        return res
    }
}

extension Double {
    init?(_ c: Character) {
        self.init(String(c))
    }
}
