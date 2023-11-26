//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 02.12.21.
//

import Foundation

class Day2: Day {
    let input: [String]

    init() throws {
        let input = try InputGetter.getInput(for: 2, part: .first)
            .split(separator: "\n")
            .map(String.init)

        self.input = input
    }

    func runPart1() throws {
        let res = input
            .reduce((depth: 0, forward: 0)) { res, curr in
                let splitted = curr.split(separator: " ")
                guard
                    splitted.count == 2,
                    let value = Int(splitted[1])
                else { return res }
                switch splitted[0] {
                case "forward":
                    return (res.depth, res.forward + value)
                case "down":
                    return (res.depth + value, res.forward)
                case "up":
                    return (res.depth - value, res.forward)
                default:
                    return res
                }
            }

        print("result is \(res.depth * res.forward)")
    }

    func runPart2() throws {
        let res = input
            .compactMap { input -> (command: Command, value: Int)? in
                let splitted = input.split(separator: " ")
                guard
                    splitted.count == 2,
                    let value = Int(splitted[1]),
                    let command = Command(rawValue: splitted[0])
                else { return nil }
                return (command: command, value: value)
            }
            .reduce(BoatValue.zero, { $0.perform(command: $1.command, with: $1.value) })


        print("result is \(res.depth * res.forward)")
    }
}

private struct BoatValue {
    let depth: Int
    let forward: Int
    let aim: Int

    func perform(command: Command, with value: Int) -> BoatValue {
        switch command {
        case .forward:
            let forward = forward + value
            let depth = depth + aim * value
            return BoatValue(depth: depth, forward: forward, aim: aim)
        case .down:
            return BoatValue(depth: depth, forward: forward, aim: aim + value)
        case .up:
            return BoatValue(depth: depth, forward: forward, aim: aim - value)
        }
    }

    static var zero: BoatValue { .init(depth: 0, forward: 0, aim: 0) }
}

private enum Command: String {
    case forward, down, up
}

extension Command {
    init?(rawValue: Substring) {
        self.init(rawValue: String(rawValue))
    }
}
