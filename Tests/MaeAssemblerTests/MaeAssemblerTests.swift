import XCTest

@testable import MaeAssembler

final class MaeAssemblerTests: XCTestCase {
	func testDelimiterLexing() {
		var delimiters: [(Character, Token)] = [
			(",", .Comma),
			(":", .Colon),
			(".", .Period),
			("(", .LeftParen),
			(")", .RightParen),
			("@", .AtSymbol),
			(";", .Semicolon),
		]
		delimiters.shuffle()
		let input = String(delimiters.map { $0.0 }).data(using: .ascii)!
		let expected_output = delimiters.map { $0.1 }
		let lexer = Lexer(input)
		for token in expected_output {
			XCTAssertEqual(token, lexer.next())
		}
	}
	func testSingleNumberLexing() {
		XCTExpectFailure("Not yet implemented.")
		let inputs = (1...100)
			.map { _ in UInt8.random(in: 0...255) }
		for i in inputs {
			let lexer = Lexer(String(i).data(using: .ascii)!)
			XCTAssertEqual(lexer.next(), Token.Literal(i))
		}
	}
}
