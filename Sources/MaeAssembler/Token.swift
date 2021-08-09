//
//  File.swift
//
//
//  Created by Mukul Agarwal on 8/7/21.
//

public enum Token: Equatable {
	case Identifier(String)
	case Literal(UInt8)
	case Comma
	case Colon
	case Period
	case Section
	case LeftParen
	case RightParen
	case AtSymbol
	case Semicolon
}
