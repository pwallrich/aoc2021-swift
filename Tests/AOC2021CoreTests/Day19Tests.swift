//
//  File.swift
//  
//
//  Created by Philipp Wallrich on 19.12.21.
//

import Foundation


import Foundation
import XCTest
@testable import AOC2021Core

final class Day19Tests: XCTestCase {
    var sut: Day19!

    override func setUpWithError() throws {
        sut = try .init()
    }

    func testPart1() {
        let input = bigInput
            .components(separatedBy: "\n")
            .getDay19Data()
        let res = sut.getOverlapping(in: input)
        XCTAssertEqual(res.count, 79)
    }

    func testPart2() {
        let input = bigInput
            .components(separatedBy: "\n")
            .getDay19Data()
        let res = sut.getOverlapping(in: input)
        XCTAssertEqual(res.distance, 3621)
    }

    func testMatch2d() {
        let b1 = [
            "---",
            "0,2,0",
            "4,1,0",
            "3,3,0",
        ].getDay19Data()

        let b2 = [
            "---",
            "-1,-1,0",
            "-5,0,0",
            "-2,1,0",
        ].getDay19Data()
        
        let res = sut.match(s1: b1[0], s2: b2[0], matchesNeeded: 3)
        XCTAssertEqual(res?.s2Point, Point3D(x: 5, y: 2, z: 0))
    }

    func testMatch2d_flippedX() {
        let b1 = [
            "---",
            "0,2,0",
            "4,1,0",
            "3,3,0",
        ].getDay19Data()

        let b2 = [
            "---",
            "1,-1,0",
            "5,0,0",
            "2,1,0",
        ].getDay19Data()


        let res = sut.match(s1: b1[0], s2: b2[0], matchesNeeded: 3)
        XCTAssertEqual(res?.s2Point, Point3D(x: 5, y: 2, z: 0))
    }

    func testMatch2d_flippedXAndY() {
        let b1 = [
            "---",
            "0,2,0",
            "4,1,0",
            "3,3,0",
        ].getDay19Data()

        let b2 = [
            "---",
            "1,1,0",
            "5,0,0",
            "2,-1,0",
        ].getDay19Data()


        let res = sut.match(s1: b1[0], s2: b2[0], matchesNeeded: 3)
        XCTAssertEqual(res?.s2Point, Point3D(x: 5, y: 2, z: 0))
    }

    func testMatch2dAllRotated() {
        let b1 = [
            "---",
            "0,2,0",
            "4,1,0",
            "3,3,0",
        ].getDay19Data()

        let i2 = [
            (x: 1,y: 1,z: 0),
            (x: 5,y: 0,z: 0),
            (x: 2,y: -1,z: 0)
        ]

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

        for (x, y, z) in rotations {
            let b2 = "---\(i2.reduce("", { "\($0)\n\($1.x * x),\($1.y * y),\($1.z * z)" }))"
                .components(separatedBy: "\n")
                .getDay19Data()

            let res = sut.match(s1: b1[0], s2: b2[0], matchesNeeded: 3)
            XCTAssertEqual(res?.s2Point, Point3D(x: 5, y: 2, z: 0))
//            XCTAssertEqual(res?.flip, Day19.Flip.none)
//            XCTAssertEqual(res?.rotation.x, x)
//            XCTAssertEqual(res?.rotation.y, y)
//            XCTAssertEqual(res?.rotation.z, z)
        }
    }

    func testMatch2dAllFlipped() {
        let b1 = [
            "---",
            "0,2,0",
            "4,1,0",
            "3,3,0",
        ].getDay19Data()

        let i2 = [
            (x: 1,y: 1,z: 0),
            (x: 5,y: 0,z: 0),
            (x: 2,y: -1,z: 0)
        ]


        for flip in Day19.Flip.allCases {
            let points = i2.map { i -> String in
                switch flip {
                case .none: return "\(i.x),\(i.y),\(i.z)"
                case .xy: return "\(i.y),\(i.x),\(i.z)"
                case .xz: return "\(i.z),\(i.y),\(i.x)"
                case .yz: return "\(i.x),\(i.z),\(i.y)"
                }
            }
            let b2 = (["---"] + points)
                .getDay19Data()

            let res = sut.match(s1: b1[0], s2: b2[0], matchesNeeded: 3)
            XCTAssertEqual(res?.s2Point, Point3D(x: 5, y: 2, z: 0))
//            XCTAssertEqual(res?.flip, flip)
//            XCTAssertEqual(res?.rotation.x, 1)
//            XCTAssertEqual(res?.rotation.y, 1)
//            XCTAssertEqual(res?.rotation.z, 1)
        }
    }

    let bigInput = """
--- scanner 0 ---
404,-588,-901
528,-643,409
-838,591,734
390,-675,-793
-537,-823,-458
-485,-357,347
-345,-311,381
-661,-816,-575
-876,649,763
-618,-824,-621
553,345,-567
474,580,667
-447,-329,318
-584,868,-557
544,-627,-890
564,392,-477
455,729,728
-892,524,684
-689,845,-530
423,-701,434
7,-33,-71
630,319,-379
443,580,662
-789,900,-551
459,-707,401

--- scanner 1 ---
686,422,578
605,423,415
515,917,-361
-336,658,858
95,138,22
-476,619,847
-340,-569,-846
567,-361,727
-460,603,-452
669,-402,600
729,430,532
-500,-761,534
-322,571,750
-466,-666,-811
-429,-592,574
-355,545,-477
703,-491,-529
-328,-685,520
413,935,-424
-391,539,-444
586,-435,557
-364,-763,-893
807,-499,-711
755,-354,-619
553,889,-390

--- scanner 2 ---
649,640,665
682,-795,504
-784,533,-524
-644,584,-595
-588,-843,648
-30,6,44
-674,560,763
500,723,-460
609,671,-379
-555,-800,653
-675,-892,-343
697,-426,-610
578,704,681
493,664,-388
-671,-858,530
-667,343,800
571,-461,-707
-138,-166,112
-889,563,-600
646,-828,498
640,759,510
-630,509,768
-681,-892,-333
673,-379,-804
-742,-814,-386
577,-820,562

--- scanner 3 ---
-589,542,597
605,-692,669
-500,565,-823
-660,373,557
-458,-679,-417
-488,449,543
-626,468,-788
338,-750,-386
528,-832,-391
562,-778,733
-938,-730,414
543,643,-506
-524,371,-870
407,773,750
-104,29,83
378,-903,-323
-778,-728,485
426,699,580
-438,-605,-362
-469,-447,-387
509,732,623
647,635,-688
-868,-804,481
614,-800,639
595,780,-596

--- scanner 4 ---
727,592,562
-293,-554,779
441,611,-461
-714,465,-776
-743,427,-804
-660,-479,-426
832,-632,460
927,-485,-438
408,393,-506
466,436,-512
110,16,151
-258,-428,682
-393,719,612
-211,-452,876
808,-476,-593
-575,615,604
-485,667,467
-680,325,-822
-627,-443,-432
872,-547,-609
833,512,582
807,604,487
839,-516,451
891,-625,532
-652,-548,-490
30,-46,-14
"""
}
