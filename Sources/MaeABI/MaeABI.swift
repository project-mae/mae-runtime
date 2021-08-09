struct ObjectHeader {
	var codeSegmentSize: UInt8
	var dataSegmentSize: UInt8
	var maxStackSize: UInt8
	init(_ c: UInt8, _ d: UInt8, _ s: UInt8) {
		codeSegmentSize = c
		dataSegmentSize = d
		maxStackSize = s
	}
	init?(bytes: [UInt8]) {
		guard
			bytes.count == 256
				&& bytes[..<4] == [
					0x7f, 0x4d, 0x41,
					0x45,
				]
				&& bytes[4] == 0xff
				&& bytes[5..<8].map(UInt.init)
					.reduce(0, +) == 256
		else {
			return nil
		}
		codeSegmentSize = bytes[5]
		dataSegmentSize = bytes[6]
		maxStackSize = bytes[7]
	}
	func dump() -> [UInt8] {
		var dump = [UInt8]()
		dump.reserveCapacity(512)
		// 0x7f helps avoid being confused as ascii file
		//                           , M   , A   , E
		dump.append(contentsOf: [0x7f, 0x4d, 0x41, 0x45])
		let total =
			Int(codeSegmentSize)
			+ Int(dataSegmentSize)
			+ Int(maxStackSize)
		var err: UInt8 = 0
		if total == 256 {
			err = 0xff
		} else if total < 256 {
			err = 0xfe
		} else if total > 256 {
			err = 0xfd
		}
		dump.append(contentsOf: [
			err,
			codeSegmentSize,
			dataSegmentSize,
			maxStackSize,
		]
		)
		dump.append(contentsOf: Array(repeating: 0x00, count: 248))
		return dump
	}
}

class Executable {
	var header: ObjectHeader? = nil
	var memory: [UInt8] = Array(repeating: 0, count: 256)

	init(header: ObjectHeader?, memory: [UInt8]) {
		precondition(memory.count == 256, "memory size must be 256 bytes")
		self.header = header
		self.memory = memory
	}

	init?(bytes: [UInt8]) {
		guard bytes.count == 512 else {
			return nil
		}
		header = ObjectHeader(bytes: Array(bytes.prefix(256)))
		memory = Array(bytes.suffix(256))
	}

	func dump() -> [UInt8] {
		var dump = [UInt8]()
		// 256 byte header (maximum, mostly unused), 256 byte program,
		dump.reserveCapacity(512)
		dump.append(
			contentsOf: header?.dump()
				?? Array(
					repeating: UInt8(0),
					count: 256))
		dump.append(contentsOf: memory)
		return dump
	}
}
