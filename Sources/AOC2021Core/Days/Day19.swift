//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 19.12.21.
//

import Foundation
import Algorithms
struct Point3D: Hashable {
    let x: Int
    let y: Int
    let z: Int

    static var zero: Point3D {
        .init(x: 0, y: 0, z: 0)
    }
}

extension Point3D: CustomStringConvertible {
    var description: String {
        return "(x:\(x), y:\(y), z:\(z))"
    }
}

extension Point3D: Comparable {
    static func < (lhs: Point3D, rhs: Point3D) -> Bool {
        guard lhs.x == rhs.x else {
            return lhs.x < lhs.x
        }
        guard lhs.y == rhs.y else {
            return lhs.y < rhs.y
        }
        return lhs.z < rhs.z
    }
}

func -(lhs: Point3D, rhs: Point3D) -> Point3D {
    return Point3D(x: lhs.x - rhs.x,
                   y: lhs.y - rhs.y,
                   z: lhs.z - rhs.z)
}

func +(lhs: Point3D, rhs: Point3D) -> Point3D {
    return Point3D(x: lhs.x + rhs.x,
                   y: lhs.y + rhs.y,
                   z: lhs.z + rhs.z)
}

class Day19: Day {
    let input: [Board]

    let rotations: [(x: Int, y: Int, z: Int)] = {
        var res: [(x: Int, y: Int, z: Int)] = [(1, 1, 1)]
        for x in [-1,1] {
            for y in [-1,1] {
                for z in [-1,1] {
                    if x == y && y == z {
                        continue
                    }
                    res.append((x, y, z))
                }
            }
        }
        return res
    }()

    init() throws {
        let input = try InputGetter.getInput(for: 19, part: .first)
            .components(separatedBy: "\n")
            .getDay19Data()

        self.input = input
    }

    func runPart1() throws {
        let res = getOverlapping(in: input)
        print("Day19 part1: \(res.count)")
        print("Day19 part2: \(res.distance)")
    }

    func runPart2() throws {
        
    }

    struct Combined: Hashable {
        let i1: Int
        let i2: Int
    }
    
    func getOverlapping(in input: [Board]) -> (count:Int, distance:Int) {
        var t = input[1...].indices.map { ($0, input[$0]) }
        var toMatch = Dictionary(uniqueKeysWithValues: t)
        var hasChecked = Set<Combined>()
        var matchedBoards: [Int: Board] = [
            0: input[0]
        ]
        var distances = [Point3D]()
        var cCount = 0
        while matchedBoards.count < input.count {
            print("restart while \(toMatch.count), \(matchedBoards.count), \(hasChecked.count), \(cCount)")
            for (i1, s1) in matchedBoards {
                for (i2,s2) in toMatch {
                    guard i1 != i2 else { continue }
                    guard
                        !hasChecked.contains(.init(i1: i1, i2: i2)),
                        !hasChecked.contains(.init(i1: i2, i2: i1)) else {
                            cCount += 1
                            continue
                        }

                    hasChecked.insert(.init(i1: i1, i2: i2))
                    guard let matched = match(s1: s1, s2: s2, matchesNeeded: 12) else {
                        continue
                    }
                    // perform transition and flip
                    var newBoard: Set<Point3D> = []
                    for point in s2 {
                        let newPoint = get(point: point, rotation: matched.rotation) + matched.s2Point
                        newBoard.insert(newPoint)
                    }
                    assert(newBoard.intersection(s1).count >= 12)
                    matchedBoards[i2] = newBoard
                    toMatch[i2] = nil
                    distances.append(matched.s2Point)
                    break
                }
            }
        }
        let res = matchedBoards.values.reduce(Set<Point3D>()) {
            $0.union($1)
        }
        let allDistances = distances
            .permutations(ofCount: 2)
            .map { points -> Int in
                let f = points[0]
                let g = points[1]
                return abs(f.x - g.x) + abs(f.y - g.y) + abs(f.z - g.z)
            }

        return (res.count, allDistances.max()!)
    }

    enum Flip: CaseIterable {
        case none, xy, xz, yz
    }

    func get(point p: Point3D, rotation: Int) -> Point3D {
        switch rotation {
        case 0: return p
        case 1: return Point3D(x: p.x, y: -p.z, z: p.y)
        case 2: return Point3D(x: p.x, y: -p.y, z: -p.z)
        case 3: return Point3D(x: p.x, y: p.z, z: -p.y)

        case 4: return Point3D(x: -p.x, y: -p.y, z: p.z)
        case 5: return Point3D(x: -p.x, y: p.z, z: p.y)
        case 6: return Point3D(x: -p.x, y: p.y, z: -p.z)
        case 7: return Point3D(x: -p.x, y: -p.z, z: -p.y)

        case 8: return Point3D(x: p.y, y: p.z, z: p.x)
        case 9: return Point3D(x: p.y, y: -p.x, z: p.z)
        case 10: return Point3D(x: p.y, y: -p.z, z: -p.x)
        case 11: return Point3D(x: p.y, y: p.x, z: -p.z)

        case 12: return Point3D(x: -p.y, y: -p.z, z: p.x)
        case 13: return Point3D(x: -p.y, y: p.x, z: p.z)
        case 14: return Point3D(x: -p.y, y: p.z, z: -p.x)
        case 15: return Point3D(x: -p.y, y: -p.x, z: -p.z)

        case 16: return Point3D(x: p.z, y: p.x, z: p.y)
        case 17: return Point3D(x: p.z, y: -p.y, z: p.x)
        case 18: return Point3D(x: p.z, y: -p.x, z: -p.y)
        case 19: return Point3D(x: p.z, y: p.y, z: -p.x)

        case 20: return Point3D(x: -p.z, y: -p.x, z: p.y)
        case 21: return Point3D(x: -p.z, y: p.y, z: p.x)
        case 22: return Point3D(x: -p.z, y: p.x, z: -p.y)
        case 23: return Point3D(x: -p.z, y: -p.y, z: -p.x)
        default: fatalError("not supported")
        }
    }

    // matches 3 Points and returns the position of the second scanner relative to the first
    func match(s1: Board, s2: Board, matchesNeeded: Int) -> (s2Point: Point3D, rotation: Int)? {
        // match points
        for i in 0..<24 {
            for p1 in s1 {
                for p2 in s2 {
                    // assume p1 and p2 are the same
                    // calculate all other points in reference
                    let toUse = get(point: p2, rotation: i)

                    let offset = p1 - toUse
                    var newS2: Set<Point3D> = []
                    for p2 in s2 {
                        let toUse = get(point: p2, rotation: i)
                        newS2.insert(Point3D(x: toUse.x, y: toUse.y, z: toUse.z) + offset)
                    }

                    let intersection = s1.intersection(newS2)
                    if intersection.count >= matchesNeeded {
                        return (offset, i)
                    }

                }
            }
        }

        return nil
    }
    typealias Board = Set<Point3D>
}

extension Array where Element == String {
    func getDay19Data() -> [Day19.Board] {
        var res: [Day19.Board] = []
        var curr: Set<Point3D> = []
        for row in self.dropFirst() where !row.isEmpty {
            if row.starts(with: "---") {
                res.append(curr)
                curr = []
                continue
            }
            let components = row.components(separatedBy: ",")
            assert(components.count == 3)
            let x = Int(components[0])!
            let y = Int(components[1])!
            let z = Int(components[2])!
            curr.insert(Point3D(x: x, y: y, z: z))
        }
        if !curr.isEmpty {
            res.append(curr)
        }
        return res
    }

}
