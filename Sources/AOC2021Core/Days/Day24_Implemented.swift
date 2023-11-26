//
//  Day24_Implemented.swift
//  AOC2021
//
//  Created by Philipp Wallrich on 24.12.21.
//

import Foundation

func run() {
    // TODO: Add 14 digits number
    var inputs: [Double] = []
    var w: Double = 0
    var x: Double = 0
    var y: Double = 0
    var z: Double = 0
    // inp w
    var inputIndex = 0
    w = inputs.removeFirst()
    inputIndex += 1

//    mul x 0
//    add x z
//    mod x 26
//    div z 1
    // do nothing
    // add x 11
    x += 11

    // never happens, always one
    x = x != w ? 1 : 0

    y = 25

    y = x * y + 1// always 26

    z = round(z / y) // always 0

    y = w + 5 // (i1)

    y = x * y // x is 1

    z = y // = i1 + 5

    // next input

    w = inputs.removeFirst()
    inputIndex += 1
    x = z.truncatingRemainder(dividingBy: z) + 13

    x = x != w ? 1 : 0 // always 1 since w is 1...9

    y = 26

    z = 26 * z // 26 * (i1 + 5)

    y = w + 5 // i2

    z = z + y // 26 * (i1 + 5) + i2 + 5

    // next input
    w = inputs.removeFirst() // i3

    x = z.truncatingRemainder(dividingBy: 26) + 12

    x = x != w ? 1 : 0 // always 1 since w is 1...9

    y = (25 * x) + 1 // always 26

    z = z * y // 26 * (26 * (i1 + 5) + i2 + 5)

    y = w + 1 // i3 + 1

    z = z + y // 26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1

    // next input

    w = inputs.removeFirst()
    x = z.truncatingRemainder(dividingBy: 26) + 15

    x = x != w ? 1 : 0 // always 1 since w is 1...9
    y = 26

    z = y * z // 26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1)

    y = w + 15 //(i4 + w)

    z = z + y // 26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15

    // next input
    w = inputs.removeFirst()
    x = z.truncatingRemainder(dividingBy: 26) + 10

    x = x != w ? 1 : 0 // always 1 since w is 1...9
    y = 26

    z = z * y // 26 * (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15)

    y = w + 2

    z = z + y // 26 * (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15) + i5 + 2

    // next input
    w = inputs.removeFirst() // i6
    x = z.truncatingRemainder(dividingBy: 26)

    z = z / 26 // (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15) + i5/26 + 2/26 -> (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15)
    x = x - 1

    x = x != w ? 1 : 0 // always 1 since z can never be 10

    y = 26

    z = z * y // 26 * (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15)

    y = w + 2

    z = y + z // 26 * (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15) + i6 + 2

    // next niput
    w = inputs.removeFirst()
    x = z.truncatingRemainder(dividingBy: 26) + 14

    x = x != w ? 1 : 0 // always 1 since w is 1...9

    y = 26

    z = z * y // 26 * (26 * (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15) + i6 + 2)

    y = w + 5

    z = y + z // 26 * (26 * (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15) + i6 + 2) + i7 + 5

    // next niput i8
    w = inputs.removeFirst()
    x = z.truncatingRemainder(dividingBy: 26)

    z = z / 26 //  (26 * (26 * (26 * (26 * (i1 + 5) + i2 + 5) + i3 + 1) + i4 + 15) + i6 + 2)

    x = x - 8


}



