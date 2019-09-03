"
Various demonstrations of reflective capabilities of Squeak.
Examples from Marcus Denker and StÈphane Ducasse
"
Class {
	#name : #ReflectionTest,
	#superclass : #TestCase,
	#category : #'Reflection-Complete'
}

{ #category : #running }
ReflectionTest >> testBecome [
	| pt1 pt2 pt3 |
	pt1 := 0@0.
	pt2 := pt1.
	pt3 := 100@100.
	pt1 become: pt3.
	self assert: pt1 = (100@100).
	self assert: pt1 == pt2.
	self assert: pt3 = (0@0).
]

{ #category : #running }
ReflectionTest >> testBecomeForward [
	| pt1 pt2 pt3 |
	pt1 := 0@0.
	pt2 := pt1.
	pt3 := 100@100.
	pt1 becomeForward: pt3.
	self assert: pt1 = (100@100).
	self assert: pt1 == pt2.
	self assert: pt2 == pt3.

]

{ #category : #running }
ReflectionTest >> testPrimitiveChangeClassTo [
	| behavior model |
	behavior := Behavior new.
	behavior superclass: Model.
	behavior setFormat: Model format.
	model := Model new.
	model primitiveChangeClassTo: behavior new.
	behavior compile: 'thisIsATest ^ 2'.
	self assert: model thisIsATest = 2.
	self should: [ Model new thisIsATest ] raise: MessageNotUnderstood
]
