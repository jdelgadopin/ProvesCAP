"
A BlockWithExit is .

Instance Variables
	block:		<Object>
	exitBlock:		<Object>

block
	- xxxxx

exitBlock
	- xxxxx

"
Class {
	#name : #BlockWithExit,
	#superclass : #Object,
	#instVars : [
		'block',
		'exitBlock'
	],
	#category : #DeutschByte
}

{ #category : #testing }
BlockWithExit class >> example [
	"BlockWithExit example"

	| theLoop coll |
	"Transcript open."
	coll := OrderedCollection new.
	1000 timesRepeat: [ coll add: 1000 atRandom ].
	theLoop := [coll do: [:each | Transcript show: each asString; cr.
							  (each < 100) ifTrue: [theLoop exit]]] withExit.
	theLoop value.

]

{ #category : #'instance creation' }
BlockWithExit class >> with: aBlock [
	^ self new with: aBlock 
]

{ #category : #control }
BlockWithExit >> exit [
	exitBlock value
]

{ #category : #control }
BlockWithExit >> value [
	exitBlock := [^ nil].
	^ block value.

]

{ #category : #'initialize-release' }
BlockWithExit >> with: aBlock [
	block := aBlock 
]
