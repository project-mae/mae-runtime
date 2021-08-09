//
//  File.swift
//
//
//  Created by Mukul Agarwal on 8/7/21.
//

import Foundation

extension Character {
	public init(_ byte: UInt8) {
		self.init(UnicodeScalar(byte))
	}
}

public class Lexer: IteratorProtocol {
	fileprivate(set) var input: Data
	private let delimiters: [Character: Token] = [
		",": .Comma,
		":": .Colon,
		".": .Period,
		"(": .LeftParen,
		")": .RightParen,
		"@": .AtSymbol,
		";": .Semicolon,
	]
	fileprivate var index: Int = -1
	init(_ input: Data) {
		self.input = input
	}
	private func next_byte() -> UInt8? {
		index += 1
		return current_byte()
	}
	private func current_byte() -> UInt8? {
		guard index < input.count && 0 <= index else { return nil }
		return input[index]
	}
	private func peek_next_byte() -> UInt8? {
		guard (index + 1) < input.count && -1 <= index else { return nil }
		return input[index + 1]
	}
	public typealias Element = Token
	public func next() -> Token? {
		while let currentByte = next_byte() {
			if let delimiter = delimiters[
				Character(currentByte)]
			{
				return delimiter
			}
		}
		return nil
	}
}
