//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 03.12.21.
//

import Foundation

class Day3: Day {
    private let input: [String]

    init() throws {
        self.input = try InputGetter.getInput(for: 3, part: .first)
            .split(separator: "\n")
            .map(String.init)

    }

    func runPart1() throws {
        let (gamma, epsilon) = calculateGammaAndEpsilon(input: input)
        print("result day 3 part 1: \(gamma * epsilon)")
    }

    func runPart2() throws {
        let (oxygen, co2) = calculateOxygenAndCO2(input: input)
        print("result day 3 part 2: \(oxygen * co2)")
    }

    func calculateGammaAndEpsilon(input: [String]) -> (gamma: Int, epsilon: Int) {
        let counts = input.reduce([Int:Int]()) { res, curr in
            var res = res
            curr
                .enumerated()
                .forEach { idx, char in
                    guard
                        let int = Int(String(char)),
                        int == 1
                    else { return }
                    res[idx, default: 0] += 1
                }
            return res
        }

        var gammaArray: [Int] = .init(repeating: 0, count: counts.count)
        var epsilonArray: [Int] = .init(repeating: 0, count: counts.count)

        for (idx, value) in counts {
            let is1MostCommon = value >= input.count / 2
            gammaArray[idx] = is1MostCommon ? 1 : 0
            epsilonArray[idx] = is1MostCommon ? 0 : 1
        }

        let gammaString = gammaArray.reduce("") { "\($0)\($1)" }
        let epsilonString = epsilonArray.reduce("") { "\($0)\($1)" }

        let gamma = Int(gammaString, radix: 2)!
        let epsilon = Int(epsilonString, radix: 2)!

        return (gamma, epsilon)
    }

    func calculateOxygenAndCO2(input: [String]) -> (oxygen: Int, co2: Int) {
        let intInput = input
            .map { $0.compactMap { Int(String($0)) } }
        var oxygenValues = intInput
        var co2Values = intInput
        var oPosition = 0
        var cPosition = 0

        while oxygenValues.count > 1 || co2Values.count > 1 {
            if oxygenValues.count > 1 {
                let dO = getMostDominant(position: oPosition, input: oxygenValues) ?? 1
                oxygenValues = oxygenValues.filter {
                    $0[oPosition] == dO
                }
                oPosition += 1
            }
            if co2Values.count > 1 {
                let cDominant = getMostDominant(position: cPosition, input: co2Values)
                let dc: Int
                if let c = cDominant {
                    dc = abs(c - 1)
                } else {
                    dc = 0
                }

                print("dc: \(dc)")
                co2Values = co2Values.filter {
                    $0[cPosition] == dc
                }
                cPosition += 1
            }
        }
        let oString = oxygenValues[0].reduce("") { "\($0)\($1)" }
        let cString = co2Values[0].reduce("") { "\($0)\($1)" }

        let gamma = Int(oString, radix: 2)!
        let epsilon = Int(cString, radix: 2)!

        return (gamma, epsilon)
    }

    private func getMostDominant(position: Int, input: [[Int]]) -> Int? {
        let result = input.reduce((0, 0)) {
            if $1[position] == 1 {
                return ($0.0, $0.1 + 1)
            } else {
                return ($0.0 + 1, $0.1)
            }
        }
        if result.0 > result.1 {
            return 0
        } else if result.0 < result.1 {
            return 1
        } else {
            return nil
        }
    }
}
