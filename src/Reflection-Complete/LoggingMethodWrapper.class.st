"
A LoggingMethodWrapper is .

Instance Variables
	invocationCount:		<Object>
	method:		<Object>
	reference:		<Object>

invocationCount
	- xxxxx

method
	- xxxxx

reference
	- xxxxx

"
Class {
	#name : #LoggingMethodWrapper,
	#superclass : #Object,
	#instVars : [
		'method',
		'reference',
		'invocationCount'
	],
	#category : #'Reflection-Complete'
}

{ #category : #examples }
LoggingMethodWrapper class >> example [
	| logger |
	logger := LoggingMethodWrapper on: Integer>>#factorial.

	logger invocationCount.
	5 factorial.
	logger invocationCount.

	logger install.
	[ 5 factorial ] ensure: [logger uninstall].
	logger invocationCount.

	10 factorial.
	logger invocationCount. 	
]

{ #category : #'instance creation' }
LoggingMethodWrapper class >> on: aCompiledMethod [
	^ self new initializeOn: aCompiledMethod
]

{ #category : #auxiliary }
LoggingMethodWrapper >> flushCache [
]

{ #category : #'initialize-release' }
LoggingMethodWrapper >> initializeOn: aCompiledMethod [
	method := aCompiledMethod.
	reference := aCompiledMethod methodReference.
	invocationCount := 0
]

{ #category : #running }
LoggingMethodWrapper >> install [
	reference actualClass methodDictionary
		at: reference selector
		put: self
]

{ #category : #accessing }
LoggingMethodWrapper >> invocationCount [
	^ invocationCount
]

{ #category : #accessing }
LoggingMethodWrapper >> invocationCount: anObject [
	invocationCount := anObject
]

{ #category : #accessing }
LoggingMethodWrapper >> method [
	^ method
]

{ #category : #accessing }
LoggingMethodWrapper >> method: anObject [
	method := anObject
]

{ #category : #auxiliary }
LoggingMethodWrapper >> methodClass: aMethodClass [
]

{ #category : #accessing }
LoggingMethodWrapper >> reference [
	^ reference
]

{ #category : #accessing }
LoggingMethodWrapper >> reference: anObject [
	reference := anObject
]

{ #category : #running }
LoggingMethodWrapper >> run: aSelector with: anArray in: aReceiver [
	invocationCount := invocationCount + 1.
	^ aReceiver withArgs: anArray executeMethod: method
]

{ #category : #auxiliary }
LoggingMethodWrapper >> selector: aSymbol [
]

{ #category : #running }
LoggingMethodWrapper >> uninstall [
	reference actualClass methodDictionary
		at: reference selector
		put: method 
]
