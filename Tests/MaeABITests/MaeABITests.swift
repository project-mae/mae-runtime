    import XCTest
    @testable import MaeABI

final class MaeRegisterTests: XCTestCase {
    func registerIndexTests() {
        let expected : [Register : UInt8] = [
            .A : 0,
            .B : 1,
            .C : 2,
            .D : 4
        ]
        for (reg, expectedIndex) in expected {
            XCTAssertEqual(reg.id, expectedIndex)
        }
    }
    func instructionParsingIsReversibleTests() throws {
        for i in UInt8(0)...UInt8(255) {
            XCTAssertEqual(try XCTUnwrap(Instruction(rawValue: i)).rawValue, i)
        }
    }
}

