"
Responsibilities:
- If a player lands here, send him or her up the ladder (forward # squares)
- Displays itself as a square with a positive offset, e.g., [6]3+>
"
Class {
	#name : #LadderSquare,
	#superclass : #BoardSquare,
	#instVars : [
		'forward'
	],
	#category : #'Examples-SnakesAndLadders'
}

{ #category : #'instance creation' }
LadderSquare class >> forward: number [
	^ self new setForward: number
]

{ #category : #playing }
LadderSquare >> destination [
	^ self forwardBy: forward
]

{ #category : #printing }
LadderSquare >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: forward asString, '+>'.
]

{ #category : #'initialize-release' }
LadderSquare >> setForward: aNumber [
	forward := aNumber.
]
