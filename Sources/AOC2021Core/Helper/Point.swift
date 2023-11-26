//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 05.12.21.
//

import Foundation

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
}

extension Point {
    func manhattan(to other: Point) -> Int {
        return abs(x - other.x) + abs(y - other.y)
    }

    func day23Distance(to other: Point) -> Int {
        if other.y == 0 || self.y == 0 {
            return manhattan(to: other)
        } else {
            let manhattan = Point(x: x, y: 0).manhattan(to: other)
            return manhattan + abs(y)
        }
    }
}
