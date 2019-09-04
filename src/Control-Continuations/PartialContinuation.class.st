"
NB: NOT a subclass of Continuation
"
Class {
	#name : #PartialContinuation,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'Control-Continuations'
}

{ #category : #'instance creation' }
PartialContinuation class >> callcc: aBlock [
	^ self currentDo: aBlock
]

{ #category : #'instance creation' }
PartialContinuation class >> currentDo: aBlock [
	| marker |
	marker := MarkerRequest signal
		ifNil: [ MarkerNotFound signal: 'Marker not found when capturing partial continuation.' ].
	^ aBlock value: (self from: thisContext sender to: marker)
]

{ #category : #'instance creation' }
PartialContinuation class >> from: aSourceContext to: aTargetContext [

	^ self basicNew initializeFrom: aSourceContext to: aTargetContext
]

{ #category : #private }
PartialContinuation >> captureFrom: aSourceContext to: aTargetContext [
	"Utilitiy method to capture the contexts between aSourceContext and aTargetContext."

	| stream context |
	context := aSourceContext.
	stream := WriteStream on: (Array new: 100).
	[ context isNil or: [ context == aTargetContext ] ] whileFalse: [
		stream nextPut: context.
		1 to: context class instSize do: [ :index |
			stream nextPut: (context instVarAt: index) ].
		1 to: context size do: [ :index |
			stream nextPut: (context at: index) ].
		context := context sender ].
	context isNil
		ifTrue: [ MarkerNotFound signal: aTargetContext printString , ' not found while capturing continuation.' ].
	^ stream contents
]

{ #category : #initialization }
PartialContinuation >> initializeFrom: aSourceContext to: aTargetContext [

	self initialize.
	values := self captureFrom: aSourceContext to: aTargetContext
]

{ #category : #accessing }
PartialContinuation >> numArgs [

	^ 1
]

{ #category : #private }
PartialContinuation >> restoreValues [
	"Restore the captured context chain."

	| stream context |
	stream := values readStream.
	[ stream atEnd ] whileFalse: [ 
		context := stream next.
		1 to: context class instSize do: [ :index | 
			context instVarAt: index put: stream next ].
		1 to: context size do: [ :index | 
			context at: index put: stream next ] ].
	^ context
]

{ #category : #private }
PartialContinuation >> unwindFrom: aSourceContext to: aTargetContext [
	"Utilitiy method to unwind and terminate from aSourceContext to aTargetContext. This implementation uses Squeak specific code implemented as primitives and is pretty fast."

	aSourceContext unwindTo: aTargetContext.
	aSourceContext terminateTo: aTargetContext
]

{ #category : #evaluating }
PartialContinuation >> value [

	^ self value: nil

]

{ #category : #evaluating }
PartialContinuation >> value: anObject [
	"Evaluate the receiving partial continuation. Note tha partial continuations can be evaluated without a marker, in this case they are just spliced at the end of the current stack and resume return back to the sender."

	| marker |
	marker := MarkerRequest signal.
	marker isNil
		ifTrue: [ marker := thisContext sender ]
		ifFalse: [ self unwindFrom: thisContext to: marker ].
	self restoreValues swapSender: marker.
	thisContext swapSender: values first.
	^ anObject
]

{ #category : #evaluating }
PartialContinuation >> valueWithArguments: anArray [ 

	^ (anArray size = 1)
		ifTrue: [ self value: anArray first ]
		ifFalse: 
			[ Error "InvalidArgumentCount"
				 signal: 'Continuations can only be resumed with one argument.' ]
]

{ #category : #evaluating }
PartialContinuation >> valueWithPossibleArguments: anArray [

	^ self value: anArray first
]
