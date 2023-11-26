//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 17.12.21.
//

import Foundation

class Day17: Day {
    let targetX: ClosedRange<Int>
    let targetY: ClosedRange<Int>

    init(targetX: ClosedRange<Int> = 111...161,
         targetY: ClosedRange<Int> = (-154)...(-101)) {
        self.targetX = targetX
        self.targetY = targetY
    }


    func runPart1() throws {
        let res = getMaxY()
        print("Day17 Part 1: \(res)")
    }

    func runPart2() throws {
        let res = getAllPossibleValues()
        print("Day17 Part 2: \(res)")
    }

    func getMaxY() -> Int {
        return dreieck(-targetY.lowerBound - 1)
    }

    func dreieck(_ n: Int) -> Int {
        (n * (n + 1)) / 2
    }

    func getAllPossibleValues() -> Int {
        var start = 1
        var t = 1
        while t < targetX.lowerBound {
            start += 1
            t += start
        }
        // 14 is first time it can hit. 161 would be one shot
        var res = 0
        for x in (start - 1)...targetX.upperBound {
            // -154 can be one shot, 153 is maximum height
            for y in targetY.lowerBound...(-targetY.lowerBound - 1) {
                var point = Point(x: 0, y: 0)
                var v = Point(x: x, y: y)
//                var count = 1
                while point.y >= -154 {
                    if targetY.contains(point.y) && targetX.contains(point.x) {
                        print("Point(x: \(x), y: \(y)),")
                        res += 1
                        break
                    }
                    (point, v) = advanceStep(point: point, velocity: v)
                }
            }
        }
        return res
    }


    func advanceStep(point: Point, velocity: Point) -> (point: Point, velocity: Point) {
        let newPoint = Point(x: point.x + velocity.x, y: point.y + velocity.y)

        let newVX: Int = velocity.x - velocity.x.signum()
        let newVY: Int = velocity.y - 1
        let newV = Point(x: newVX, y: newVY)
        return (newPoint, newV)
    }
}
