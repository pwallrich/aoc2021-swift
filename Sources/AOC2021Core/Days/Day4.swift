//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 04.12.21.
//

import Foundation

class Board: Equatable {
    static func == (lhs: Board, rhs: Board) -> Bool {
        lhs.board == rhs.board && lhs.colCount == rhs.colCount
    }

    struct Value: Equatable {
        let value: Int
        let hasSeen: Bool

        init(value: Int, hasSeen: Bool = false) {
            self.value = value
            self.hasSeen = hasSeen
        }
        
        init(_ value: Int, hasSeen: Bool = false) {
            self.value = value
            self.hasSeen = hasSeen
        }
    }
    var board: [Value]
    let colCount: Int

    init(board: [Value], colCount: Int) {
        self.board = board
        self.colCount = colCount
    }

    func process(number: Int) -> Bool {
        if let index = (board.firstIndex { $0.value == number }) {
            board[index] = Value(value: number, hasSeen: true)
            if hasWonRow(changedIndex: index) || hasWonCol(changedIndex: index) {
                return true
            }
        }
        return false
    }

    func hasWonRow(changedIndex: Int) -> Bool {
        // row
        print("\(changedIndex % colCount)")
        let rowStart = changedIndex - changedIndex % colCount
        for i in (rowStart..<(rowStart + colCount)) {
            print("evaluating: \(i): \(board[i])")
            if !board[i].hasSeen {
                return false
            }
        }
        return true
    }

    func hasWonCol(changedIndex: Int) -> Bool {
        // col
        var index = changedIndex % colCount
        while index < board.count {
            if !board[index].hasSeen {
                return false
            }
            index += colCount
        }
        return true
    }
    func calculateRemaining() -> Int {
        board.reduce(0) { res, curr in
            res + (curr.hasSeen ? 0 : curr.value)
        }
    }


}

class Day4: Day {
    private let input: [String]

    init() throws {
        self.input = try InputGetter.getInput(for: 4, part: .first)
            .components(separatedBy: "\n")

    }

    func runPart1() throws {
        let res = playGame(input: input)
        print("result day1: \(res)")

    }

    func runPart2() throws {
        let res = getLastWinning(input: input)
        print("result day2: \(res)")
    }

    func playGame(input: [String]) -> Int {
        // MARK: - Parse boards
        guard !input.isEmpty else { return -1 }
        let numbers = input[0]
            .components(separatedBy: ",")
            .compactMap { Int($0) }

        let boards = parseBoards(input: input)

        // MARK: - Play game
        for number in numbers {
            for board in boards {
                let hasWon = board.process(number: number)
                if hasWon {
                    return board.calculateRemaining() * number
                }
            }
        }
        return -1
    }

    func getLastWinning(input: [String]) -> Int {
        // MARK: - Parse boards
        guard !input.isEmpty else { return -1 }
        let numbers = input[0]
            .components(separatedBy: ",")
            .compactMap { Int($0) }

        var boards = parseBoards(input: input).map { ($0, false) }

        // MARK: - Play game
        for number in numbers {
            for (idx, board) in boards.enumerated() {
                guard !board.1 else { continue }
                let hasWon = board.0.process(number: number)
                if hasWon {
                    let cNotWon = boards.filter { !$0.1 }.count
                    if cNotWon == 1 {
                        return board.0.calculateRemaining() * number
                    } else {
                        boards[idx] = (board.0, true)
                    }
                }
            }
        }
        return -1
    }

    func parseBoards(input: [String]) -> [Board] {
        var boards: [Board] = []

        var currBoard = [Board.Value]()
        let colCount = input
            .dropFirst(2)[2]
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .count
        for row in input.dropFirst(2) {
            guard !row.isEmpty else {
                boards.append(.init(board: currBoard, colCount: colCount))
                currBoard = []
                continue
            }
            for col in row.components(separatedBy: .whitespaces) {
                guard !col.isEmpty, col != " " else { continue }
                let value = Int(col)!
                currBoard.append(.init(value: value, hasSeen: false))
            }
        }
        if !currBoard.isEmpty {
            boards.append(.init(board: currBoard, colCount: colCount))
        }
        return boards
    }
}
