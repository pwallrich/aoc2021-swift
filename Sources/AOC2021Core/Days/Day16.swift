//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 16.12.21.
//

import Foundation

struct Packet: Equatable {
    enum PType: Equatable {
        case literal([UInt8])
        case `operator`(opValue: Int, packets: [Packet])
    }
    let type: PType
    let version: Int

    var versionSum: Int {
        switch type {
        case .literal:
            return version
        case let .operator(_, packets):
            return version + packets.map(\.versionSum).reduce(0,+)
        }
    }

    var result: Int {
        switch type {
        case .literal(let value):
            return value.getIntFromBinary(start: value.startIndex, end: value.endIndex - 1)
        case let .operator(opValue, packets):
            return calculateResult(opValue: opValue, children: packets)
        }
    }

    private func calculateResult(opValue: Int, children: [Packet]) -> Int {
        let values = children.map(\.result)
        switch opValue {
        case 0: return values.reduce(0, +)
        case 1: return values.reduce(1, *)
        case 2: return values.min()!
        case 3: return values.max()!
        case 5: return values[0] > values[1] ? 1 : 0
        case 6: return values[0] < values[1] ? 1 : 0
        case 7: return values[0] == values[1] ? 1 : 0
        default:
            fatalError("unsupported operator")
        }
    }
}


class Day16: Day {
    let input: [UInt8]

    init() throws {
        let input = try InputGetter.getInput(for: 16, part: .first)
            .getDay16Values()

        self.input = input
    }

    func runPart1() throws {
        let res = sumAllVersions(in: input)
        print("Day16 Part 1: \(res)")
    }

    func runPart2() throws {
        let res = evaluatePackets(in: input)
        print("Day16 Part 2: \(res)")
    }

    func sumAllVersions(in input: [UInt8]) -> Int {
        let (packets, _) = getPackets(from: input)
        return packets.map(\.versionSum).reduce(0, +)
    }

    func evaluatePackets(in input: [UInt8]) -> Int {
        let (packets, _) = getPackets(from: input)
        return packets.map(\.result).reduce(0, +)
    }

    func getPackets(from values: [UInt8], stopAfter: Int? = nil) -> (packets: [Packet], endIndex: Int) {
        var res = [Packet]()
        var current = 0
        while current < values.count && values.count > current + 6 {
            if (values[current...].first { $0 == 1 }) == nil {
                // trailing zeroes are ignored
                break
            }
            // early exit if given
            if let stop = stopAfter, res.count == stop {
                break
            }
            let version = values.getIntFromBinary(start: current, end: current + 2)
            let type = values.getIntFromBinary(start: current + 3, end: current + 5)
            current += 6
            switch type {
            case 4:
                let literalValue = parseLiteral(remaining: Array(values[current..<values.endIndex]))
                current += literalValue.chunks * 5
                res.append(.init(type: .literal(literalValue.values), version: version))
            default:
                let subSet = Array(values[current..<values.endIndex])
                let (packet, newIndex) = parseOperator(remaining: subSet, version: version, type: type)
                current += newIndex
                res.append(packet)
            }
        }
        return (res, current)
    }

    func parseLiteral(remaining: [UInt8]) -> (values: [UInt8], chunks: Int) {
        var bits: [UInt8] = []
        var current = 0
        var chunks = 0
        repeat {
            bits.append(contentsOf: remaining[(current + 1)..<(current + 5)])
            current += 5
            chunks += 1
        } while current < remaining.count && remaining[current - 5] == 1
        return (bits, chunks)
    }

    func parseOperator(remaining: [UInt8], version: Int, type: Int) -> (packets: Packet, endIndex: Int) {
        let sizeLength = remaining[0] == 0 ? 15 : 11
        let number = remaining.getIntFromBinary(start: 1, end: sizeLength)

        let toUse: [UInt8]
        var stopAfter: Int?
        if sizeLength == 11 {
            toUse = Array(remaining[(sizeLength + 1)...])
            stopAfter = number
        } else {
            toUse = Array(remaining[(sizeLength + 1)...(number + sizeLength)])
        }
        let packets = getPackets(from: toUse, stopAfter: stopAfter)
        let newIndex = sizeLength == 11 ? sizeLength + 1 + packets.endIndex : number + sizeLength + 1
        return (.init(type: .operator(opValue: type, packets: packets.packets), version: version), newIndex)
    }
}

extension String {
    func getDay16Values() -> [UInt8] {
        let integers = self.compactMap(\.hexDigitValue)
        let values = integers
            .map { String($0, radix: 2) }
            .map { $0.pad(toSize: 4) }
            .flatMap { $0.map { UInt8(String($0))! }}
        return values
    }

    func pad(toSize: Int) -> String {
      var padded = self
      for _ in 0..<(toSize - count) {
        padded = "0" + padded
      }
        return padded
    }
}
extension Array where Element == UInt8 {

    func getIntFromBinary(start: Index, end: Index) -> Int {
        let str = self[start...end].reduce("") { "\($0)\($1)" }
        return Int(str, radix: 2)!
    }
}
