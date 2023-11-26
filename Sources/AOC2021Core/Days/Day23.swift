//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 23.12.21.
//

import Foundation
let pointMap: [Character: Int] = [
    "A": 2,
    "B": 4,
    "C": 6,
    "D": 8
]

let moveMap: [Character: Int] = [
    "A": 1,
    "B": 10,
    "C": 100,
    "D": 1000
]

class Day23: Day {
    //#############
    //#...........#
    //###D#A#D#C###
    //  #D#C#B#A#
    //  #D#B#A#C#
    //  #C#A#B#B#
    //  #########

    var board: [Point: Character] = [:]
    var isBigBoard: Bool = true

    init(board: [Point: Character]) {
        self.board = board
        isBigBoard = board.count > 8
    }

    init() {}

    func runPart1() throws {
        isBigBoard = false

        board[Point(x: 2, y: -1)] = "D"
        board[Point(x: 2, y: -2)] = "C"

        board[Point(x: 4, y: -1)] = "A"
        board[Point(x: 4, y: -2)] = "A"

        board[Point(x: 6, y: -1)] = "D"
        board[Point(x: 6, y: -2)] = "B"

        board[Point(x: 8, y: -1)] = "C"
        board[Point(x: 8, y: -2)] = "B"

        let res = advance(board: board)

        print("took route:")
        print("----------------------")
        var total = 0
        for step in res!.route {
            print("moved \(step.value) from \(step.old) to \(step.new), cost: \(moveMap[step.value]!)")
            total += moveMap[step.value]! * step.old.day23Distance(to: step.new)
            print("total: \(total)")
            step.board.debugLog(isBigBoard: false)
            print()
        }

        print("----------------------")

        print("res: \(res!.steps)")
    }

    func runPart2() throws {
        isBigBoard = true
        board = [:]

        board[Point(x: 2, y: -1)] = "D"
        board[Point(x: 2, y: -2)] = "D"
        board[Point(x: 2, y: -3)] = "D"
        board[Point(x: 2, y: -4)] = "C"

        board[Point(x: 4, y: -1)] = "A"
        board[Point(x: 4, y: -2)] = "C"
        board[Point(x: 4, y: -3)] = "B"
        board[Point(x: 4, y: -4)] = "A"

        board[Point(x: 6, y: -1)] = "D"
        board[Point(x: 6, y: -2)] = "B"
        board[Point(x: 6, y: -3)] = "A"
        board[Point(x: 6, y: -4)] = "B"

        board[Point(x: 8, y: -1)] = "C"
        board[Point(x: 8, y: -2)] = "A"
        board[Point(x: 8, y: -3)] = "C"
        board[Point(x: 8, y: -4)] = "B"

        let res = advance(board: board)

        print("took route:")
        print("----------------------")
        var total = 0
        for step in res!.route {
            print("moved \(step.value) from \(step.old) to \(step.new), cost: \(moveMap[step.value]!)")
            total += moveMap[step.value]! * step.old.day23Distance(to: step.new)
            print("total: \(total)")
            step.board.debugLog(isBigBoard: false)
            print()
        }

        print("----------------------")

        print("res: \(res!.steps)")

    }

    func log(_ string: String) {
//        print(string)
    }

    var cache: [[Point: Character]: (steps: Int, route: [(value: Character, old: Point, new: Point, board: [Point: Character])])] = [:]

    func advance(board: [Point: Character]) -> (steps: Int, route: [(value: Character, old: Point, new: Point, board: [Point: Character])])? {
        if let val = cache[board] {
            if val.steps == -1 {
                return nil
            }
            log("hit cache")
            return val
        }
        log("recursion with:")
//        board.debugLog(isBigBoard: isBigBoard)

        if board.areAllinCorrectPlace() {
            return (0, [])
        }
        var minCount: Int?
        var currentCheapest: [(value: Character, old: Point, new: Point, board: [Point: Character])] = []

        pointLoop: for point in board {
            if board.isInCorrectPlace(point, isBigBoard: isBigBoard) {
                continue
            }
            if board.isAtTop(point) {
                if let newP = board.canMoveToOwnRoomFromTop(point, isBigBoard: isBigBoard) {
                    // move to own room
                    var newBoard = board
                    newBoard[newP] = point.value
                    newBoard[point.key] = nil

                    if let (stepCount, route) = advance(board: newBoard) {
                        let count = point.key.day23Distance(to: newP) * moveMap[point.value]!
                        let newCount = stepCount + count
                        if newCount < (minCount ?? .max) {
                            minCount = min(stepCount + count, minCount ?? .max)
                            currentCheapest = [(point.value, point.key, newP, newBoard)] + route
                        }
                    } else {
                        log("couldn't finish board")
                    }
                } else {
                    // do nothing
                }
            } else if let newP = board.canMoveToOwnRoom(point, isBigBoard: isBigBoard) {
                var newBoard = board
                newBoard[newP] = point.value
                newBoard[point.key] = nil

                if let (stepCount, route) = advance(board: newBoard) {
                    let count = point.key.day23Distance(to: newP) * moveMap[point.value]!
                    let newCount = stepCount + count
                    if newCount < (minCount ?? .max) {
                        minCount = min(stepCount + count, minCount ?? .max)
                        currentCheapest = [(point.value, point.key, newP, newBoard)] + route
                    }
                } else {
                    log("couldn't finish board")
                }
                // move to own room
            } else {
                // move to top row
                let points = board.canMoveToTopRow(point)
                for newP in points {
                    var newBoard = board
                    newBoard[newP] = point.value
                    newBoard[point.key] = nil

                    if let (stepCount, route) = advance(board: newBoard) {
                        let count = point.key.day23Distance(to: newP) * moveMap[point.value]!
                        let newCount = stepCount + count
                        if newCount < (minCount ?? .max) {
                            minCount = min(stepCount + count, minCount ?? .max)
                            currentCheapest = [(point.value, point.key, newP, newBoard)] + route
                        }
                    } else {
                        log("couldn't finish board")
                    }
                }
            }
        }
        if let minCount = minCount {
            cache[board] = (minCount, currentCheapest)
            return (minCount, currentCheapest)
        } else {
            cache[board] = (-1, [])
            return nil
        }
    }
}

extension Dictionary where Value == Character, Key == Point {

    func isAtTop(_ point: Element) -> Bool {
        return point.key.x == 0
    }

    func canMoveToOwnRoomFromTop(_ point: Element, isBigBoard: Bool) -> Point? {
        let ownRoom = filter { $0.key.x == pointMap[point.value]! }
        for p in ownRoom {
            if p.value != point.value {
                return nil
            }
        }

        for x in Swift.min(point.key.x, pointMap[point.value]!)...Swift.max(point.key.x, pointMap[point.value]!) where x != point.key.x {
            if let _ = self[Point(x: x, y: 0)] {
                return nil
            }
        }

        if let max = ownRoom.map(\.key.y).max() {
            return Point(x: pointMap[point.value]!, y: max + 1)
        } else {
            return isBigBoard ? Point(x: pointMap[point.value]!, y: -4) : Point(x: pointMap[point.value]!, y: -2)
        }
    }

    func canMoveToOwnRoom(_ point: Element, isBigBoard: Bool) -> Point? {
        let column = filter { $0.key.x == point.key.x }
        for p in column {
            if p.key.y > point.key.y {
                return nil
            }
        }

        return canMoveToOwnRoomFromTop(point, isBigBoard: isBigBoard)
    }

    func canMoveToTopRow(_ point: Element) -> [Point] {
        guard
            point.key.y != 0,
            canMoveUp(point)
        else {
            return []
        }
        var res = [Point]()
        outer: for i in [0, 1, 3, 5, 7, 9, 10] {
            let newP = Point(x: i, y: 0)
            if self[newP] != nil {
                // already other element there
                continue
            }

            for x in Swift.min(point.key.x, i)...Swift.max(point.key.x, i) {
                if self[Point(x: x, y: 0)] != nil {
    //                    print("can't reach because top way is blocked at \(x)")
                    continue outer
                }
            }
            res.append(newP)
        }
        return res
    }

    func canMoveUp(_ point: Element) -> Bool {
        let column = filter { $0.key.x == point.key.x }
        for p in column {
            if p.key.y > point.key.y {
                return false
            }
        }
        return true
    }

    func areAllinCorrectPlace() -> Bool {
        for point in self {
            if point.key.x != pointMap[point.value]! {
                return false
            }
        }
        return true
    }
    func isInCorrectPlace(_ element: (key: Point, value: Character), isBigBoard: Bool) -> Bool {
        guard element.key.x == pointMap[element.value] else { return false }

        for y in (isBigBoard ? -4 : -2)...(-1) {
            // only check existing points, if there is a hole in it, there's an error somewhere else
            if let point = self[Point(x: pointMap[element.value]!, y: y)] {
                if point != element.value {
                    return false
                }
            }
        }
        return true

    }

    func debugLog(isBigBoard: Bool) {
        let ymin = isBigBoard ? -5 : -3
        for y in (ymin...1).reversed() {
            for x in (-1...11) {
                let toPrint: Character
                if let value = self[Point(x: x, y: y)] {
                    toPrint = value
                } else if y == 0 && x != -1 && x != 11 {
                    toPrint = "."
                } else if [2, 4, 6, 8].contains(x) && y != ymin && y != 1 {
                    toPrint = "."
                } else {
                    toPrint = "#"
                }
                print(toPrint, terminator: "")
            }
            print()
        }
    }
}
