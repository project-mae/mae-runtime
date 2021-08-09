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
}
