//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 01.12.21.
//

import Foundation

public final class AOC2021 {
    private var days: [Int: Day]
    
    public init() throws {
        days = [
            1: try Day1(),
            2: try Day2(),
            3: try Day3(),
            4: try Day4(),
            5: try Day5(),
            6: try Day6(),
            7: try Day7(),
            8: try Day8(),
            9: try Day9(),
            10: try Day10(),
            11: try Day11(),
            12: try Day12(),
            13: try Day13(),
            14: try Day14(),
            15: try Day15(),
            16: try Day16(),
            17: Day17(),
            18: try Day18(),
            19: try Day19(),
            20: try Day20(),
            21: Day21(),
            22: try Day22(),
            23: Day23(),
            24: try Day24(),
            25: try Day25()
        ]
    }

    public func run(day: Int, part: Part) throws {
        guard let day = days[day] else {
            throw DayError.notImplemented
        }
        switch part {
        case .first:
            try day.runPart1()
        case .second:
            try day.runPart2()
        }
    }
}
