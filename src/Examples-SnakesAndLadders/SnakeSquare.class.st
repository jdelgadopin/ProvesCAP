"
Responsibilities:
- If a player lands here, send him or her backwards (back # squares)
- Displays itself as a square with a negative offset, e.g., <-3[5]
"
Class {
	#name : #SnakeSquare,
	#superclass : #BoardSquare,
	#instVars : [
		'back'
	],
	#category : #'Examples-SnakesAndLadders'
}

{ #category : #'instance creation' }
SnakeSquare class >> back: number [
	^ self new setBack: number
]

{ #category : #playing }
SnakeSquare >> destination [
	^ self backwardBy: back
]

{ #category : #printing }
SnakeSquare >> printOn: aStream [
	aStream nextPutAll: '<-', back asString.
	super printOn: aStream.
]

{ #category : #'initialize-release' }
SnakeSquare >> setBack: aNumber [
	back := aNumber.
]
