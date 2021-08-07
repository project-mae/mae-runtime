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
}
