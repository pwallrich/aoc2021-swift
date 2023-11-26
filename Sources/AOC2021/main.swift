import ArgumentParser
import AOC2021Core

struct AOC2021: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Runs the AOC for 2021"
    )

    @Argument(help: "The day that should be run (1-25)")
    private var day: Int

    @Argument(help: "The part of the day that should be run (either 1 or 2)")
    private var part: Int

    func run() throws {
        print("running AOC2021 day \(day) part \(part)")
        guard 1...25 ~= day  else {
            throw Error.invalidDay
        }
        guard let part = AOC2021Core.Part(rawValue: part) else {
            throw Error.invalidPart
        }
        try AOC2021Core.AOC2021().run(day: day, part: part)
    }
}

extension AOC2021 {
    enum Error: Swift.Error {
        case invalidDay
        case invalidPart
    }
}

AOC2021.main()
