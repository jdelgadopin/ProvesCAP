"
HaltDemo new foo.
HaltDemo new bar.

Only the second halts within foo.
"
Class {
	#name : #HaltDemo,
	#superclass : #Object,
	#category : #'Reflection-Complete'
}

{ #category : #'as yet unclassified' }
HaltDemo >> bar [
	^ (self foo), 'bar'
]

{ #category : #'as yet unclassified' }
HaltDemo >> foo [
	self haltIf: #bar.
	^ 'foo'
]

{ #category : #'as yet unclassified' }
HaltDemo >> haltIf: aSelector [
	| context |
	context := thisContext.
	[context sender isNil]
		whileFalse:
			[context := context sender.
			(context selector = aSelector)
			ifTrue: [ Halt signal ] ].

]
