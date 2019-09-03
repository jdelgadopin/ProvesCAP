Class {
	#name : #LoggingProxyTest,
	#superclass : #TestCase,
	#category : #'Reflection-Complete'
}

{ #category : #running }
LoggingProxyTest >> testDelegation [
	| point |
	point := 1@2.
	LoggingProxy new become: point.
	self assert: point invocationCount = 0.
	self assert: point + (3@4) = (4@6).
	self assert: point invocationCount = 1.
]

{ #category : #running }
LoggingProxyTest >> testSelf [
	| point |
	point := 1 @ 2.
	LoggingProxy new become: point.
	self assert: point invocationCount = 0.
	self assert: (point rectangle: 3 @ 4) area = 4.
	"rectangle: does two self-sends"
	"oops -- self sends are not intercepted"
	self deny: point invocationCount = 4
]
