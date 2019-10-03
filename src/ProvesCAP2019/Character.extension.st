Extension { #name : #Character }

{ #category : #'*ProvesCAP2019' }
Character >> check: aChar [
	| at cg |
	at := (self = $A and: [ aChar = $T ]) or: [ self = $T and: [ aChar = $A ] ].
	cg := (self = $C and: [ aChar = $G ]) or: [ self = $G and: [ aChar = $C ] ].
	^ at or: [ cg ]
	
]
