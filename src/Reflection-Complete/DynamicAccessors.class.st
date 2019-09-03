"
A DynamicAccessors is .

Instance Variables
	x:		<Object>

x
	- xxxxx

"
Class {
	#name : #DynamicAccessors,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Reflection-Complete'
}

{ #category : #'error-handling' }
DynamicAccessors >> doesNotUnderstand: aMessage [ 
	| messageName |
	messageName := aMessage selector asString.
	(self class instVarNames includes: messageName)
		ifTrue: [self class compile: messageName , String cr , ' ^ ' , messageName.
			^ aMessage sendTo: self].
	super doesNotUnderstand: aMessage
]

{ #category : #'as yet unclassified' }
DynamicAccessors >> x [
 ^ x
]
