Class {
	#name : #DynamicAccessorsTest,
	#superclass : #TestCase,
	#category : #'Reflection-Complete'
}

{ #category : #running }
DynamicAccessorsTest >> tearDown [
	"DynamicAccessors methodDict removeDangerouslyKey: #x ifAbsent: []"
	DynamicAccessors removeSelector: #x.
]

{ #category : #running }
DynamicAccessorsTest >> testAccessors [
	self deny: (DynamicAccessors methodDict keys includes: #x).
	self assert: DynamicAccessors new x = nil.
	self assert: (DynamicAccessors methodDict keys includes: #x).
]
