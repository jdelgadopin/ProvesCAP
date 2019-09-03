"
A MinimalObject is .

Instance Variables
	calls:		<Object>
	subject:		<Object>

calls
	- xxxxx

subject
	- xxxxx

"
Class {
	#name : #MinimalObject,
	#superclass : #ProtoObject,
	#instVars : [
		'subject',
		'calls'
	],
	#category : #'Reflection-Complete'
}

{ #category : #'as yet unclassified' }
MinimalObject class >> demo [
	"Transcript closeAllViews; open.
	MinimalObject demo"
	| set minObject |
	"create subject and wrapper"
	set := Set new.	
	minObject := MinimalObject new.

	set add: 0.

	"swap the pointers"
	set become: minObject.
	set add: 1; add: 2.

	"swap the pointers"
	minObject become: set.
	set add: 3.
	set inspect.

]

{ #category : #'as yet unclassified' }
MinimalObject >> MOcalls [
	"Choose an uncommon method name"
	^ calls
]

{ #category : #'as yet unclassified' }
MinimalObject >> doesNotUnderstand: aMessage [
	Transcript show: 'performing ', aMessage printString; cr.
	calls := calls + 1.
	^ subject perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #'as yet unclassified' }
MinimalObject >> initialize [
	"When we become: anotherObject, this reference will also get swapped"
	subject := self.
	calls := 0.
]
