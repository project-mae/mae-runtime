import XCTest
@testable import MaeABI

final class MaeABITests: XCTestCase {
    func testRegisterIndex() {
        let expected : [Register : UInt8] = [
            .A : 0,
            .B : 1,
            .C : 2,
            .D : 3
        ]
        for (reg, expectedIndex) in expected {
            XCTAssertEqual(reg.id, expectedIndex)
        }
    }
    func testInstructionParsingIsReversible() throws {
        for i in UInt8.min...UInt8.max /* 0...255*/ {
            if let instruction = Instruction(rawValue: i) {
                let index = try XCTUnwrap(instructionLookupTable.firstIndex(of: instruction))
                XCTAssertEqual(index, Int(i))
            }
        }
    }
    func testHeaderDump() throws {
            let header = constructRandomHeader()
            XCTAssertEqual(header.dump().prefix(8), [0x7f, 0x4d, 0x41, 0x45, 0xff, header.codeSegmentSize, header.dataSegmentSize, header.maxStackSize])
    }
    func testExecutableDump() throws {
            let header = constructRandomHeader()
            let memory = (1...256).map {_ in UInt8.random(in: 0...255)}
            let executable = Executable(header: header, memory: memory)
            var expectedDump = [0x7f, 0x4d, 0x41, 0x45, 0xff, header.codeSegmentSize, header.dataSegmentSize, header.maxStackSize]
            expectedDump.append(contentsOf: Array(repeating: 0, count: 248))
            expectedDump.append(contentsOf: memory)
            XCTAssertEqual(expectedDump, executable.dump())
    }
    func testHeaderConstruction() {
        let first = Int.random(in: 0...255)
        let second = Int.random(in: 0...(256-first))
        let third = 256 - first - second
        let code = UInt8(first)
        let data = UInt8(second)
        let stack = UInt8(third)
        var rawBytes = [0x7f, 0x4d, 0x41, 0x45, 0xff, code, data, stack]
        rawBytes.append(contentsOf: Array(repeating: 0, count: 248))
        XCTAssertEqual(rawBytes, ObjectHeader(bytes: rawBytes)?.dump())
    }
    func testExecutableConstruction() {
        let header = constructRandomHeader()
        let memory = (1...256).map {_ in UInt8.random(in: 0...255)}
        var rawBytes = [0x7f, 0x4d, 0x41, 0x45, 0xff, header.codeSegmentSize, header.dataSegmentSize, header.maxStackSize]
        rawBytes.append(contentsOf: Array(repeating: 0, count: 248))
        rawBytes.append(contentsOf: memory)
        XCTAssertEqual(rawBytes, Executable(bytes: rawBytes)?.dump())
    }
    func constructRandomHeader() -> ObjectHeader {
        let first = Int.random(in: 0...255)
        let second = Int.random(in: 0...(256-first))
        let third = 256 - first - second
        let code = UInt8(first)
        let data = UInt8(second)
        let stack = UInt8(third)
        return ObjectHeader(code, data, stack)
    }
}
