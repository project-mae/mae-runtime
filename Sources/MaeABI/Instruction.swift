public enum Instruction: Equatable {
	case Halt, Reset
	case Zero(register: Register)
	case Copy(from: Register, to: Register)
	case Swap(first: Register, second: Register)

	case ZeroMemory(address: Register)
	case LoadMemory(address: Register, into: Register)
	case StoreMemory(value: Register, address: Register)

	case Add(Register)
	case Subtract(Register)
	case Multiply(Register)
	case Divide(Register)
	case Modulo(Register)

	case BitwiseNot
	case BitwiseAnd(Register)
	case BitwiseOr(Register)
	case BitwiseXor(Register)

	case RotateLeft(amount: Register)
	case RotateRight(amount: Register)
	case ShiftRight(amount: Register)
	case ShiftLeft(amount: Register)

	case Equal(first: Register, second: Register)
	case NotEqual(first: Register, second: Register)
	case LessThan(first: Register, second: Register)

	case Jump(address: Register)
	case JumpForward(amount: Register)
	case JumpBackward(amount: Register)

	case ConditionalJump(address: Register)
	case ConditionalJumpForward(amount: Register)
	case ConditionalJumpBackward(amount: Register)

	case PutTop(value: UInt8)
	case PutBottom(value: UInt8)
	public init?(rawValue: UInt8) {
		let i = Int(rawValue)
		guard i < instructionLookupTable.count,
			let v = instructionLookupTable[i]
		else {
			return nil
		}
		self = v
	}
}

// temporary solution
// TODO: write better solution
public let instructionLookupTable: [Instruction?] = [
	// 0000 0000 - 0000 0011
	.Halt,
	.Reset,
	.BitwiseNot,
	nil,

	// 0000 01 <2 register>
	.Zero(register: .A),
	.Zero(register: .B),
	.Zero(register: .C),
	.Zero(register: .D),

	// 0000 1000 - 0000 1111
	nil, nil, nil, nil, nil, nil, nil, nil,

	// 0001 <2 from> <2 to>
	.Copy(from: .A, to: .A), .Copy(from: .A, to: .B), .Copy(from: .A, to: .C),
	.Copy(from: .A, to: .D),
	.Copy(from: .B, to: .A), .Copy(from: .B, to: .B), .Copy(from: .B, to: .C),
	.Copy(from: .B, to: .D),
	.Copy(from: .C, to: .A), .Copy(from: .C, to: .B), .Copy(from: .C, to: .C),
	.Copy(from: .C, to: .D),
	.Copy(from: .D, to: .A), .Copy(from: .D, to: .B), .Copy(from: .D, to: .C),
	.Copy(from: .D, to: .D),

	// 0010 <2 first> <2 second>
	.Swap(first: .A, second: .A), .Swap(first: .A, second: .B),
	.Swap(first: .A, second: .C),
	.Swap(first: .A, second: .D),
	.Swap(first: .B, second: .A), .Swap(first: .B, second: .B),
	.Swap(first: .B, second: .C),
	.Swap(first: .B, second: .D),
	.Swap(first: .C, second: .A), .Swap(first: .C, second: .B),
	.Swap(first: .C, second: .C),
	.Swap(first: .C, second: .D),
	.Swap(first: .D, second: .A), .Swap(first: .D, second: .B),
	.Swap(first: .D, second: .C),
	.Swap(first: .D, second: .D),

	// 0011 00 <2 address>
	.ZeroMemory(address: .A),
	.ZeroMemory(address: .B),
	.ZeroMemory(address: .C),
	.ZeroMemory(address: .D),

	// 0011 0100 - 0011 1111
	nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,

	// 0100 <2 address> <2 into>
	.LoadMemory(address: .A, into: .A), .LoadMemory(address: .A, into: .B),
	.LoadMemory(address: .A, into: .C), .LoadMemory(address: .A, into: .D),
	.LoadMemory(address: .B, into: .A), .LoadMemory(address: .B, into: .B),
	.LoadMemory(address: .B, into: .C), .LoadMemory(address: .B, into: .D),
	.LoadMemory(address: .C, into: .A), .LoadMemory(address: .C, into: .B),
	.LoadMemory(address: .C, into: .C), .LoadMemory(address: .C, into: .D),
	.LoadMemory(address: .D, into: .A), .LoadMemory(address: .D, into: .B),
	.LoadMemory(address: .D, into: .C), .LoadMemory(address: .D, into: .D),

	// 0101 <2 value> <2 address>
	.StoreMemory(value: .A, address: .A), .StoreMemory(value: .A, address: .B),
	.StoreMemory(value: .A, address: .C), .StoreMemory(value: .A, address: .D),
	.StoreMemory(value: .B, address: .A), .StoreMemory(value: .B, address: .B),
	.StoreMemory(value: .B, address: .C), .StoreMemory(value: .B, address: .D),
	.StoreMemory(value: .C, address: .A), .StoreMemory(value: .C, address: .B),
	.StoreMemory(value: .C, address: .C), .StoreMemory(value: .C, address: .D),
	.StoreMemory(value: .D, address: .A), .StoreMemory(value: .D, address: .B),
	.StoreMemory(value: .D, address: .C), .StoreMemory(value: .D, address: .D),

	// 0110 00 <2 operand>
	.Add(.A), .Add(.B), .Add(.C), .Add(.D),
	// 0110 01 <2 operand>
	.Subtract(.A), .Subtract(.B), .Subtract(.C), .Subtract(.D),
	// 0110 10 <2 operand>
	.Multiply(.A), .Multiply(.B), .Multiply(.C), .Multiply(.D),
	// 0110 11 <2 operand>
	.Divide(.A), .Divide(.B), .Divide(.C), .Divide(.D),
	// 0111 00 <2 operand>
	.Modulo(.A), .Modulo(.B), .Modulo(.C), .Modulo(.D),
	// 0111 01 <2 operand>
	.BitwiseAnd(.A), .BitwiseAnd(.B), .BitwiseAnd(.C), .BitwiseAnd(.D),
	// 0111 10 <2 operand>
	.BitwiseOr(.A), .BitwiseOr(.B), .BitwiseOr(.C), .BitwiseOr(.D),
	// 0111 11 <2 operand>
	.BitwiseXor(.A), .BitwiseXor(.B), .BitwiseXor(.C), .BitwiseXor(.D),
	// 1000 00 <2 operand>
	.RotateLeft(amount: .A), .RotateLeft(amount: .B), .RotateLeft(amount: .C),
	.RotateLeft(amount: .D),
	// 1000 01 <2 operand>
	.RotateRight(amount: .A), .RotateRight(amount: .B), .RotateRight(amount: .C),
	.RotateRight(amount: .D),
	// 0111 10 <2 operand>
	.ShiftLeft(amount: .A), .ShiftLeft(amount: .B), .ShiftLeft(amount: .C),
	.ShiftLeft(amount: .D),
	// 1000 11 <2 operand>
	.ShiftRight(amount: .A), .ShiftRight(amount: .B), .ShiftRight(amount: .C),
	.ShiftRight(amount: .D),
	// 1001 <2 first> <2 second>
	.Equal(first: .A, second: .A), .Equal(first: .A, second: .B),
	.Equal(first: .A, second: .C),
	.Equal(first: .A, second: .D),
	.Equal(first: .B, second: .A), .Equal(first: .B, second: .B),
	.Equal(first: .B, second: .C),
	.Equal(first: .B, second: .D),
	.Equal(first: .C, second: .A), .Equal(first: .C, second: .B),
	.Equal(first: .C, second: .C),
	.Equal(first: .C, second: .D),
	.Equal(first: .D, second: .A), .Equal(first: .D, second: .B),
	.Equal(first: .D, second: .C),
	.Equal(first: .D, second: .D),
	// 1010 <2 first> <2 second>
	.NotEqual(first: .A, second: .A), .NotEqual(first: .A, second: .B),
	.NotEqual(first: .A, second: .C), .NotEqual(first: .A, second: .D),
	.NotEqual(first: .B, second: .A), .NotEqual(first: .B, second: .B),
	.NotEqual(first: .B, second: .C), .NotEqual(first: .B, second: .D),
	.NotEqual(first: .C, second: .A), .NotEqual(first: .C, second: .B),
	.NotEqual(first: .C, second: .C), .NotEqual(first: .C, second: .D),
	.NotEqual(first: .D, second: .A), .NotEqual(first: .D, second: .B),
	.NotEqual(first: .D, second: .C), .NotEqual(first: .D, second: .D),
	// 1011 <2 first> <2 second>
	.LessThan(first: .A, second: .A), .LessThan(first: .A, second: .B),
	.LessThan(first: .A, second: .C), .LessThan(first: .A, second: .D),
	.LessThan(first: .B, second: .A), .LessThan(first: .B, second: .B),
	.LessThan(first: .B, second: .C), .LessThan(first: .B, second: .D),
	.LessThan(first: .C, second: .A), .LessThan(first: .C, second: .B),
	.LessThan(first: .C, second: .C), .LessThan(first: .C, second: .D),
	.LessThan(first: .D, second: .A), .LessThan(first: .D, second: .B),
	.LessThan(first: .D, second: .C), .LessThan(first: .D, second: .D),

	// 1100 00 <2 address>
	.Jump(address: .A), .Jump(address: .B), .Jump(address: .C), .Jump(address: .D),

	// 1100 01 <2 amount>
	.JumpForward(amount: .A), .JumpForward(amount: .B), .JumpForward(amount: .C),
	.JumpForward(amount: .D),

	// 1100 10 <2 amount>
	.JumpBackward(amount: .A), .JumpBackward(amount: .B), .JumpBackward(amount: .C),
	.JumpBackward(amount: .D),

	// 1100 11 <2 address>
	.ConditionalJump(address: .A), .ConditionalJump(address: .B),
	.ConditionalJump(address: .C),
	.ConditionalJump(address: .D),

	// 1101 00 <2 amount>
	.ConditionalJumpForward(amount: .A), .ConditionalJumpForward(amount: .B),
	.ConditionalJumpForward(amount: .C), .ConditionalJumpForward(amount: .D),

	// 1101 01 <2 amount>
	.ConditionalJumpBackward(amount: .A), .ConditionalJumpBackward(amount: .B),
	.ConditionalJumpBackward(amount: .C), .ConditionalJumpBackward(amount: .D),

	// 1101 1000 - 1101 1111
	nil, nil, nil, nil, nil, nil, nil, nil,

	// 1110 <4 value>
	.PutTop(value: 0x0), .PutTop(value: 0x1), .PutTop(value: 0x2), .PutTop(value: 0x3),
	.PutTop(value: 0x4), .PutTop(value: 0x5), .PutTop(value: 0x6), .PutTop(value: 0x7),
	.PutTop(value: 0x8), .PutTop(value: 0x9), .PutTop(value: 0xa), .PutTop(value: 0xb),
	.PutTop(value: 0xc), .PutTop(value: 0xd), .PutTop(value: 0xe), .PutTop(value: 0xf),

	// 1111 <4 value>
	.PutBottom(value: 0x0), .PutBottom(value: 0x1), .PutBottom(value: 0x2),
	.PutBottom(value: 0x3),
	.PutBottom(value: 0x4), .PutBottom(value: 0x5), .PutBottom(value: 0x6),
	.PutBottom(value: 0x7),
	.PutBottom(value: 0x8), .PutBottom(value: 0x9), .PutBottom(value: 0xa),
	.PutBottom(value: 0xb),
	.PutBottom(value: 0xc), .PutBottom(value: 0xd), .PutBottom(value: 0xe),
	.PutBottom(value: 0xf),

]
