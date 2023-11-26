//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 16.12.21.
//

import XCTest
@testable import AOC2021Core

final class Day16Tests: XCTestCase {

    func testPart1() throws {
        let sut = try Day16()
        let input1 = "8A004A801A8002F478".getDay16Values()
        let res1 = sut.sumAllVersions(in: input1)
        XCTAssertEqual(res1, 16)

        let input2 = "620080001611562C8802118E34".getDay16Values()
        let res2 = sut.sumAllVersions(in: input2)
        XCTAssertEqual(res2, 12)

        let input3 = "C0015000016115A2E0802F182340".getDay16Values()
        let res3 = sut.sumAllVersions(in: input3)
        XCTAssertEqual(res3, 23)

        let input4 = "A0016C880162017C3686B18A3D4780".getDay16Values()
        let res4 = sut.sumAllVersions(in: input4)
        XCTAssertEqual(res4, 31)
    }

    func testPart2() throws {
        let sut = try Day16()
        let input1 = "C200B40A82".getDay16Values()
        let res1 = sut.evaluatePackets(in: input1)
        XCTAssertEqual(res1, 3)

        let input2 = "04005AC33890".getDay16Values()
        let res2 = sut.evaluatePackets(in: input2)
        XCTAssertEqual(res2, 54)

        let input3 = "880086C3E88112".getDay16Values()
        let res3 = sut.evaluatePackets(in: input3)
        XCTAssertEqual(res3, 7)

        let input4 = "CE00C43D881120".getDay16Values()
        let res4 = sut.evaluatePackets(in: input4)
        XCTAssertEqual(res4, 9)

        let input5 = "D8005AC2A8F0".getDay16Values()
        let res5 = sut.evaluatePackets(in: input5)
        XCTAssertEqual(res5, 1)

        let input6 = "F600BC2D8F".getDay16Values()
        let res6 = sut.evaluatePackets(in: input6)
        XCTAssertEqual(res6, 0)

        let input7 = "9C005AC2F8F0".getDay16Values()
        let res7 = sut.evaluatePackets(in: input7)
        XCTAssertEqual(res7, 0)

        let input8 = "9C0141080250320F1802104A08".getDay16Values()
        let res8 = sut.evaluatePackets(in: input8)
        XCTAssertEqual(res8, 1)
    }

    func testConversion() {
        let input = "D2FE28"
        let res = input.getDay16Values()
        let expected: [UInt8] = [1,1,0,1,0,0,1,0,1,1,1,1,1,1,1,0,0,0,1,0,1,0,0,0]

        XCTAssertEqual(res, expected)
    }

    func testPacketParsing() throws {
        let sut = try Day16()
        let input = "D2FE28".getDay16Values()

        let res = sut.getPackets(from: input)

        XCTAssertEqual(res.packets, [
            .init(type: .literal([0,1,1,1,1,1,1,0,0,1,0,1]), version: 6)
        ])
    }

    func testPacketParsing2() throws {
        let sut = try Day16()
        let input = "38006F45291200".getDay16Values()

        let res = sut.getPackets(from: input)

        let expected = Packet(type: .operator(opValue: 6, packets: [
            .init(type: .literal([1,0,1,0]), version: 6),
            .init(type: .literal([0,0,0,1,0,1,0,0]), version: 2)
        ]), version: 1)

        XCTAssertEqual(res.packets, [expected])
    }

    func testPacketParsing3() throws {
        let sut = try Day16()
        let input = "EE00D40C823060".getDay16Values()

        let res = sut.getPackets(from: input)

        let expected = Packet(type: .operator(opValue: 3, packets: [
            .init(type: .literal([0,0,0,1]), version: 2),
            .init(type: .literal([0,0,1,0]), version: 4),
            .init(type: .literal([0,0,1,1]), version: 1),
        ]), version: 7)

        XCTAssertEqual(res.packets, [expected])
    }
}
