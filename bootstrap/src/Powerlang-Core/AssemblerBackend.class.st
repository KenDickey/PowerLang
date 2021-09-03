Class {
	#name : #AssemblerBackend,
	#superclass : #Object,
	#instVars : [
		'wordSize',
		'memory'
	],
	#category : #'Powerlang-Core-Assembler'
}

{ #category : #basic }
AssemblerBackend >> add: source1 to: source2andDest [
	self subclassResponsibility
]

{ #category : #'operations - arithmetic' }
AssemblerBackend >> addDouble: source1 to: source2andDest [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> addImm: imm to: dest [
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> addressBitSize [
	^self addressSize * 8

]

{ #category : #accessing }
AssemblerBackend >> addressLength [
	^wordSize * 8
]

{ #category : #accessing }
AssemblerBackend >> addressSize [
	"Return the size of address in bytes, e.g, 4 for 32bit archs
	 and 8 for 64bit archs"

	^wordSize
]

{ #category : #alignment }
AssemblerBackend >> alignTo: aNumber [
	| current count |
	current := memory position.
	count := (current alignedTo: aNumber) - current.
	self nop: count
]

{ #category : #basic }
AssemblerBackend >> and: source1andDest with: source2 [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> and: source1andDest withImm: imm [
	self subclassResponsibility
]

{ #category : #relocation }
AssemblerBackend >> baseAddress [
	^memory baseAddress
]

{ #category : #private }
AssemblerBackend >> bitLengthOf: anInteger [
	(anInteger between: -16r80 and: 16r7F) ifTrue: [^8].
	(anInteger between: -16r8000 and: 16r7FFF) ifTrue: [^16].
	(anInteger between: -16r80000000 and: 16r7FFFFFFF) ifTrue: [^32].
	(anInteger between: -16r8000000000000000 and: 16r7FFFFFFFFFFFFFFF)
		ifTrue: [^64].
	(anInteger
		between: -16r80000000000000000000000000000000
		and: 16r7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
		ifTrue: [^128].
	^nil
]

{ #category : #basic }
AssemblerBackend >> breakpoint [
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> bytes [
	^memory bytes
]

{ #category : #accessing }
AssemblerBackend >> call: srcReg [ 
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> callIndirect: aMemRef [ 
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> clearHigh32: srcAndDstReg [
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> codeSize [
	^memory codeSize
]

{ #category : #basic }
AssemblerBackend >> compare: reg1 with: reg2 [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> compare: reg1 withImm: imm [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> compare: reg1 withMem: aMemRef [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> convert: src toDouble: dst [
	self subclassResponsibility
]

{ #category : #labels }
AssemblerBackend >> currentAddress [
	^memory currentAddress
]

{ #category : #accessing }
AssemblerBackend >> dec: srcAndDstReg [ 
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> decMem: aMemRef [ 
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> divDouble: src1andDstReg by: src2reg [ 
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> divide: srcAndDstReg extendingTo: extReg by: divisorReg [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> exchange: srcAndDstReg withMem: aMemRef [
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> inc: srcAndDstReg [ 
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> initialize [
	memory := RelocatableBuffer new.
]

{ #category : #basic }
AssemblerBackend >> jumpTo: label [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> jumpToMem: aMemRef [
	self subclassResponsibility
]

{ #category : #memory }
AssemblerBackend >> lea: dstReg withMem: srcMemRef [
	^self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> load: dstReg convertingDoubleToIntegerFromMem: srcMemRef [
	self subclassResponsibility
]

{ #category : #memory }
AssemblerBackend >> load: dstReg fromMem: srcMemRef [
	"Load `dstReg` from memory location `srcMemRef`.
	 The size of data loaded is specified in `srcMemRef`.

	 When loading 32bits into 64bit register, high 32bits must be
	 cleared (in other words, 32bit value is *zero* extended to
	 64bits and stored in `dstReg`.

	 However, when loading 16bits or 8bits, high 48 or 56 bits
	 are *left intact*.

	 This somewhat weird behavior is heritage of x86.
	"

	^ self subclassResponsibility

]

{ #category : #basic }
AssemblerBackend >> load: dstReg withTIBat: indexReg [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> load: dstReg withThreadVariableAt: indexReg [
	self subclassResponsibility
]

{ #category : #memory }
AssemblerBackend >> loadDouble: dstReg fromMem: srcMemRef [ 
	"Load 64-bit floating point `dstReg` from memory location `srcMemRef`"
	
	^ self subclassResponsibility
]

{ #category : #memory }
AssemblerBackend >> memRef [
	self subclassResponsibility
]

{ #category : #memory }
AssemblerBackend >> memRef16 [
	"Return clean instance of memory reference."

	^ self memRef length: 16; yourself

]

{ #category : #memory }
AssemblerBackend >> memRef16: baseReg offset: offsetReg [
	^ self memRef16
		base: baseReg;
		index: offsetReg;
		scale: 1;
		yourself
]

{ #category : #memory }
AssemblerBackend >> memRef16: baseReg offsetImm: offsetImm [
	^ self memRef16
		base: baseReg;
		displacement: offsetImm;
		yourself
]

{ #category : #memory }
AssemblerBackend >> memRef32 [
	"Return clean instance of memory reference."

	^ self memRef length: 32; yourself

]

{ #category : #memory }
AssemblerBackend >> memRef32: baseReg index: indexReg [
	^ self memRef32 
		base: baseReg; 
		displacement: -4;
		index: indexReg;
		scale: 4;
		yourself

]

{ #category : #memory }
AssemblerBackend >> memRef32: baseReg indexImm: indexImm [
	^ self memRef32 
		base: baseReg; 
		displacement: (indexImm - 1) * 4;
		yourself

]

{ #category : #memory }
AssemblerBackend >> memRef32: baseReg offset: offsetReg [
	^ self memRef32
		base: baseReg;
		index: offsetReg;
		scale: 1;
		yourself
]

{ #category : #memory }
AssemblerBackend >> memRef64 [
	"Return clean instance of memory reference."

	^ self memRef length: 64; yourself

]

{ #category : #memory }
AssemblerBackend >> memRef64: baseReg indexImm: indexImm [
	^ self memRef64
		base: baseReg;
		displacement: (indexImm - 1) * 8;
		yourself
]

{ #category : #memory }
AssemblerBackend >> memRef8 [
	"Return clean instance of memory reference."

	^ self memRef length: 8; yourself

]

{ #category : #memory }
AssemblerBackend >> memRef8: baseReg index: indexReg [
	^ self memRef8 
		base: baseReg; 
		displacement: -1;
		index: indexReg;
		scale: 1;
		yourself

]

{ #category : #memory }
AssemblerBackend >> memRef8: baseReg indexImm: indexImm [
	^ self memRef8
		base: baseReg; 
		displacement: (indexImm - 1);
		yourself

]

{ #category : #memory }
AssemblerBackend >> memRef: baseReg index: indexRef [
	^ self memRef 
		base: baseReg; 
		displacement: self addressSize negated;
		index: indexRef;
		scale: self addressSize;
		yourself

]

{ #category : #memory }
AssemblerBackend >> memRef: baseReg index: indexRef offsetImm: anInteger [
	^ self memRef 
		base: baseReg; 
		displacement: anInteger;
		index: indexRef;
		scale: self addressSize;
		yourself

]

{ #category : #memory }
AssemblerBackend >> memRef: baseReg indexImm: indexImm [
	^ self memRef 
		base: baseReg; 
		displacement: (indexImm - 1) * self addressSize;
		yourself

]

{ #category : #memory }
AssemblerBackend >> memRef: baseReg offset: indexReg [
	^ self memRef
		base: baseReg;
		index: indexReg;
		scale: 1;
		yourself
]

{ #category : #memory }
AssemblerBackend >> memRefAatT [
^self memRef: self regA index: self regT
]

{ #category : #memory }
AssemblerBackend >> memRefSPatT [
	^ self memRef: self regSP index: self regT
]

{ #category : #memory }
AssemblerBackend >> memory [
	^memory
]

{ #category : #alignment }
AssemblerBackend >> moveImm: imm to: dstReg [
	"Load constant to register `dstImm`"

	self subclassResponsibility

]

{ #category : #alignment }
AssemblerBackend >> moveX: srcReg into: dstReg [
	"move from X-type register srcReg into general purpose dstReg"
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> mulDouble: src1andDstReg by: src2reg [ 
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> multiply: src1AndDstLoReg by: src2reg wideningTo: dstHiReg [
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> nativeCode [
	^ NativeCode new code: memory bytes
]

{ #category : #basic }
AssemblerBackend >> or: src1andDest withImm: imm [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> popIntoMem: dstMemRef [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> push: srcReg [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> pushImm: imm [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> pushMem: aMemRef [
	self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regA [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regB [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regC [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regE [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regFP [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
AssemblerBackend >> regFalse [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regG [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
AssemblerBackend >> regIP [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regM [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regNil [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regR [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regS [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regSP [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regT [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regTrue [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regV [
	^self subclassResponsibility
]

{ #category : #'registers - IR' }
AssemblerBackend >> regX0 [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
AssemblerBackend >> regX1 [
	^ self subclassResponsibility

]

{ #category : #basic }
AssemblerBackend >> reset [
	memory reset
]

{ #category : #memory }
AssemblerBackend >> roundDouble: srcReg into: dstReg [ 
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> shiftLeft: srcAndDst byImm: count [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> shiftRight: srcAndDst byImm: count [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> shiftRightArithmetic: srcAndDst by: countReg [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> shiftRightArithmetic: srcAndDst byImm: count [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> sqrtDouble: srcReg into: dstReg [
	self subclassResponsibility
]

{ #category : #memory }
AssemblerBackend >> store: srcReg intoMem: dstMemRef [
	^self subclassResponsibility
]

{ #category : #memory }
AssemblerBackend >> storeDouble: srcReg intoMem: dstMemRef [ 
	^ self subclassResponsibility
]

{ #category : #initialization }
AssemblerBackend >> stream [
	^memory stream
]

{ #category : #accessing }
AssemblerBackend >> sub: src1 from: src2AndDst [
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> subDouble: src1 from: src2AndDst [ 
	self subclassResponsibility
]

{ #category : #accessing }
AssemblerBackend >> subImm: imm from: srcAndDst [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> test: src1Reg with: src2Reg [
	self subclassResponsibility
]

{ #category : #basic }
AssemblerBackend >> test: srcReg withImm: imm [
	self subclassResponsibility
]

{ #category : #services }
AssemblerBackend >> wordSize [
	^wordSize
]