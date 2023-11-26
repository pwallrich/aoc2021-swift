import XCTest
@testable import AOC2021Core

final class Day4Tests: XCTestCase {
    let input = [
        "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
        "",
        "22 13 17 11  0",
        " 8  2 23  4 24",
        "21  9 14 16  7",
        " 6 10  3 18  5",
        " 1 12 20 15 19",
        "",
        " 3 15  0  2 22",
        " 9 18 13 17  5",
        "19  8  7 25 23",
        "20 11 10 24  4",
        "14 21 16 12  6",
        "",
        "14 21 17 24  4",
        "10 16 15  9 19",
        "18  8 23 26 20",
        "22 11 13  6  5",
        " 2  0 12  3  7",
    ]

    func testPart1() throws {
        let sut = try Day4()
        let res = sut.playGame(input: input)

        XCTAssertEqual(res, 4512)
    }

    func testPart2() throws {
        let sut = try Day4()
        let res = sut.getLastWinning(input: input)

        XCTAssertEqual(res, 1924)
    }

    func testParseBoards() throws {
        let sut = try Day4()
        let res = sut.parseBoards(input: input)

        let expected = Board(board: [
                .init(22), .init(13), .init(17), .init(11), .init(0),
                .init(8), .init(2), .init(23), .init(4), .init(24),
                .init(21), .init(9), .init(14), .init(16), .init(7),
                .init(6), .init(10), .init(3), .init(18), .init(5),
                .init(1), .init(12), .init(20), .init(15), .init(19)
            ], colCount: 5)

        XCTAssertEqual(res[0], expected)

        let lastExpected = Board(board: [
                .init(14), .init(21), .init(17), .init(24), .init(4),
                .init(10), .init(16), .init(15), .init(9), .init(19),
                .init(18), .init(8), .init(23), .init(26), .init(20),
                .init(22), .init(11), .init(13), .init(6), .init(5),
                .init(2), .init(0), .init(12), .init(3), .init(7)
            ], colCount: 5)
        XCTAssertEqual(res.last, lastExpected)
    }

    func testBoardProcess() {
        let board = Board(board: [
            .init(5), .init(6), .init(7), .init(8),
            .init(9), .init(10), .init(11), .init(12),
            .init(13), .init(14), .init(15), .init(16),
            .init(17), .init(18), .init(19), .init(20),
        ], colCount: 5)

        _ = board.process(number: 10)
        _ = board.process(number: 13)
        _ = board.process(number: 19)

        let expected =  Board(board: [
            .init(value: 5, hasSeen: false), .init(value: 6, hasSeen: false), .init(value: 7, hasSeen: false), .init(value: 8, hasSeen: false),
            .init(value: 9, hasSeen: false), .init(value: 10, hasSeen: true), .init(value: 11, hasSeen: false), .init(value: 12, hasSeen: false),
            .init(value: 13, hasSeen: true), .init(value: 14, hasSeen: false), .init(value: 15, hasSeen: false), .init(value: 16, hasSeen: false),
            .init(value: 17, hasSeen: false), .init(value: 18, hasSeen: false), .init(value: 19, hasSeen: true), .init(value: 20, hasSeen: false),
        ], colCount: 4)

        XCTAssertEqual(board, expected)
    }

    func testBoardHasWonRow() {
        let board = Board(board: [
            .init(value: 5, hasSeen: false),.init(value: 6, hasSeen: false),.init(value: 7, hasSeen: false),.init(value: 8, hasSeen: false),
            .init(value: 9, hasSeen: true),.init(value: 10, hasSeen: true),.init(value: 11, hasSeen: true),.init(value: 12, hasSeen: true),
            .init(value: 13, hasSeen: false),.init(value: 14, hasSeen: false),.init(value: 15, hasSeen: false),.init(value: 16, hasSeen: false),
            .init(value: 17, hasSeen: false),.init(value: 18, hasSeen: false),.init(value: 19, hasSeen: false),.init(value: 20, hasSeen: false),
        ], colCount: 4)

        XCTAssertEqual(board.hasWonRow(changedIndex: 0), false)
        XCTAssertEqual(board.hasWonRow(changedIndex: 5), true)
        XCTAssertEqual(board.hasWonRow(changedIndex: 2), false)
        XCTAssertEqual(board.hasWonRow(changedIndex: 3), false)
    }

    func testBoardHasWonCol() {
        let board = Board(board: [
            .init(value: 5, hasSeen: false),.init(value: 6, hasSeen: true),.init(value: 7, hasSeen: false),.init(value: 8, hasSeen: false),
            .init(value: 9, hasSeen: false),.init(value: 10, hasSeen: true),.init(value: 11, hasSeen: false),.init(value: 12, hasSeen: false),
            .init(value: 13, hasSeen: false),.init(value: 14, hasSeen: true),.init(value: 15, hasSeen: false),.init(value: 16, hasSeen: false),
            .init(value: 17, hasSeen: false),.init(value: 18, hasSeen: true),.init(value: 19, hasSeen: false),.init(value: 20, hasSeen: false),
        ], colCount: 4)

        XCTAssertEqual(board.hasWonCol(changedIndex: 0), false)
        XCTAssertEqual(board.hasWonCol(changedIndex: 1), true)
        XCTAssertEqual(board.hasWonCol(changedIndex: 2), false)
        XCTAssertEqual(board.hasWonCol(changedIndex: 3), false)
    }

    func testBoardCalculateValue() {
        let board = Board(board: [
            .init(value: 5, hasSeen: false),.init(value: 6, hasSeen: true),.init(value: 7, hasSeen: false),.init(value: 8, hasSeen: false),
            .init(value: 9, hasSeen: false),.init(value: 10, hasSeen: true),.init(value: 11, hasSeen: false),.init(value: 12, hasSeen: false),
            .init(value: 13, hasSeen: false),.init(value: 14, hasSeen: true),.init(value: 15, hasSeen: false),.init(value: 16, hasSeen: false),
            .init(value: 17, hasSeen: false),.init(value: 18, hasSeen: true),.init(value: 19, hasSeen: false),.init(value: 20, hasSeen: false),
        ], colCount: 5)

        XCTAssertEqual(board.calculateRemaining(), 5 + 7 + 8 + 9 + 11 + 12 + 13 + 15 + 16 + 17 + 19 + 20)
    }
}
