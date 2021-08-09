//
//  File.swift
//
//
//  Created by Mukul Agarwal on 6/28/21.
//

import Collections

public enum Register {
	case A, B, C, D
}

extension Register {
	private static var registers: OrderedSet<Self> = [.A, .B, .C, .D]
	private static var publiclyAvailable: Set<Self> = [.A, .B, .C, .D]
	public var availableToUser: Bool {
		return Register.publiclyAvailable.contains(self)
	}
	public var id: UInt8 {
		return UInt8(exactly: Register.registers.firstIndex(of: self)!)!
	}
}
