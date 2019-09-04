Class {
	#name : #PartialContinuationTest,
	#superclass : #TestCase,
	#category : #'Control-Continuations'
}

{ #category : #private }
PartialContinuationTest >> mark: aBlock [

	^ aBlock on: MarkerRequest do: [ :request | request resume: thisContext home ]
]

{ #category : #private }
PartialContinuationTest >> markDiscardingResultOf: aBlock [

	aBlock on: MarkerRequest do: [ :request | request resume: thisContext home ]
]

{ #category : #testing }
PartialContinuationTest >> testEnsure [
	| kk count |
	
	" before evaluation, ensure blocks should be unwound "
	count := 0.
	self mark: [ 2 * (PartialContinuation callcc: [ :cc | kk := cc. 0 ]) ].
	self assert: (self mark: [
		[ kk value: 3 ]
			ensure: [ count := count + 1 ] ])
				= 6.
	self assert: count = 1.
	
	" ensure blocks within the continuation should be unwound as well "
	count := 0.
	self mark: [ [ 2 * (PartialContinuation callcc: [ :cc | kk := cc. 0 ]) ] ensure: [ count := count + 1 ] ].
	self assert: count = 1.
	self assert: (kk value: 2) = 4.
	self assert: count = 2.
	self assert: (kk value: 3) = 6.
	self assert: count = 3
]

{ #category : #testing }
PartialContinuationTest >> testMarkerOnValue [
	| kk captured seen |
	captured := false.
	seen := false.
	self	shouldnt: [
			self markDiscardingResultOf: [ | value |
				value := PartialContinuation callcc: [ :cc | kk := cc. captured := true ].
				seen := true.
				value ] ]
		raise: Error.
		
	self assert: captured.
	self assert: seen.
	captured := false.
	seen := false.
	"Make sure the marker method is not included in the continuation and the continuation returns directly
	into the marker method."
	self assert: (self mark: [ kk value: 123. 456 ]) = 123.
	self deny: captured.
	self assert: seen.
]

{ #category : #testing }
PartialContinuationTest >> testNestedEvaluation [
	| k1 k2 |
	self assert: (self mark: [ 
		2 * (PartialContinuation callcc: [ :c1 | 
			k1 := c1. 
			3 * (PartialContinuation callcc: [ :c2 |
				k2 := c2.
				4 ]) ]) ])
					= 24.
					
	self assert: (self mark: [
		k1 value: 5 ])
			= 10.
	self assert: (self mark: [
		k2 value: 5 ])
			= 30
]

{ #category : #testing }
PartialContinuationTest >> testNoMarkerOnCall [
	| captured seen |
	captured := false.
	seen := false.
	self	should: [ PartialContinuation callcc: [ :cc | captured := true ]. seen := true ]
		raise: Error.
		
	self deny: captured.
	self deny: seen.
]

{ #category : #testing }
PartialContinuationTest >> testNoMarkerOnValue [
	| kk captured seen |
	captured := false.
	seen := false.
	self	shouldnt: [
			self markDiscardingResultOf: [ | value |
				value := PartialContinuation callcc: [ :cc | kk := cc. captured := true ].
				seen := true.
				value ] ]
		raise: Error.
		
	self assert: captured.
	self assert: seen.
	captured := false.
	seen := false.
	"Make sure the marker method was not included in the continuation"
	self assert: (kk value: 123) = 123.
	self deny: captured.
	self assert: seen.
]

{ #category : #testing }
PartialContinuationTest >> testReentrant [
	| kk |
	self assert: (self mark: [ 
		2 * (PartialContinuation callcc: [ :cc | 
			kk := cc. 2 ]) ]) 
				= 4.
	
	self assert: (self mark: [
		kk value: 3 ]) 
			= 6.
	self assert: (self mark: [
		kk value: 4 ]) 
			= 8.
	self assert: (self mark: [
		kk value: 5 ]) 
			= 10
]

{ #category : #testing }
PartialContinuationTest >> testSimple [

	self assert: (self mark: [ PartialContinuation callcc: [ :cc | cc value: true ] ])
]
