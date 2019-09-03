"
A LoggingProxy is .

Instance Variables
	invocationCount:		<Object>
	subject:		<Object>

invocationCount
	- xxxxx

subject
	- xxxxx

"
Class {
	#name : #LoggingProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'subject',
		'invocationCount'
	],
	#category : #'Reflection-Complete'
}

{ #category : #'error-handling' }
LoggingProxy >> doesNotUnderstand: aMessage [ 
	Transcript show: 'performing ', aMessage printString; cr.
	invocationCount := invocationCount + 1.
	^ aMessage sendTo: subject

]

{ #category : #'initialize-release' }
LoggingProxy >> initialize [
	invocationCount := 0.
	subject := self.
]

{ #category : #accessing }
LoggingProxy >> invocationCount [
	^ invocationCount
]
