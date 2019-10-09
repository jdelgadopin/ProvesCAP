"
SnakesAndLadders example playToEnd

A simple board game in which players roll a die to move from the starting square to the end. A square may contain a snake (moves you back) or a ladder (moves you up). If youland on a square already occupied, you go back to the start. If you move past the end, you reverse direction the remaining number of moves.

See http://en.wikipedia.org/wiki/Snakes_and_ladders for the rules of the game

SnakesAndLadders has the following responsibilities:
- enable scripting of an initial configuration of squares and players
- keep track of the rules of the game
- keep track whose turn it is to play
- initiate a move
- play a game to the end
- report on moves and intermediate game states
- stop when the game is over

Typical usage (see the example):
- Instantiate a new SnakesAndLadders
- Add squares, snakes and ladders to build the game board 
- Join players
- Play single moves or PlayToEnd
"
Class {
	#name : #SnakesAndLadders,
	#superclass : #Object,
	#instVars : [
		'players',
		'squares',
		'turn',
		'die',
		'over'
	],
	#category : #'Examples-SnakesAndLadders'
}

{ #category : #documentation }
SnakesAndLadders class >> example [
	"self example playToEnd"

	^ (self new)
		add: FirstSquare new;
		add: (LadderSquare forward: 4);
		add: BoardSquare new;
		add: BoardSquare new;
		add: BoardSquare new;
		add: BoardSquare new;
		add: (LadderSquare forward: 2);
		add: BoardSquare new;
		add: BoardSquare new;
		add: BoardSquare new;
		add: (SnakeSquare back: 6);
		add: BoardSquare new;
		join: (GamePlayer named: 'Jack');
		join: (GamePlayer named: 'Jill');
		yourself
]

{ #category : #documentation }
SnakesAndLadders class >> example2 [
	"self example2 playToEnd"

	^ (self new)
		add: FirstSquare new;
		add: BoardSquare new;
		add: (LadderSquare forward: 4);
		add: BoardSquare new;
		add: BoardSquare new;
		add: (SnakeSquare back: 2);
		add: BoardSquare new;
		add: (LadderSquare forward: 3);
		add: BoardSquare new;
		add: BoardSquare new;
		add: (SnakeSquare back: 4);
		add: BoardSquare new;
		add: BoardSquare new;
		join: (GamePlayer named: 'Jack');
		join: (GamePlayer named: 'Jill');
		yourself
]

{ #category : #'initialize-release' }
SnakesAndLadders >> add: aSquare [ 
	squares add: aSquare.
	aSquare setPosition: squares size board: self
]

{ #category : #testing }
SnakesAndLadders >> at: position [
	^ squares at: position
]

{ #category : #playing }
SnakesAndLadders >> checkResult [
	^ self currentPlayer position = self lastPosition
		ifTrue: [
			over := true.
			' -- ', self currentPlayer asString, ' wins!'
			]
		ifFalse: [ '' ]
]

{ #category : #testing }
SnakesAndLadders >> currentPlayer [
	^ players at: turn
]

{ #category : #testing }
SnakesAndLadders >> firstSquare [
	^ squares first
]

{ #category : #'initialize-release' }
SnakesAndLadders >> initialize [
	super initialize.
	die := Die new.
	squares := OrderedCollection new.
	players := OrderedCollection new.
	turn := 1.
	over := false.
]

{ #category : #'initialize-release' }
SnakesAndLadders >> invariant [
	"Should also check that snakes and ladders lead to ordinary squares, and do not bounce
	past the beginning or end of the board."
	^ squares size > 1
		and: [players size > 1
		and: [turn >= 1
		and: [turn <= players size]]]
]

{ #category : #testing }
SnakesAndLadders >> isNotOver [
	^ self isOver not
]

{ #category : #testing }
SnakesAndLadders >> isOver [
	^ over
]

{ #category : #'initialize-release' }
SnakesAndLadders >> join: aPlayer [
	players add: aPlayer.
	aPlayer moveTo: self firstSquare.

]

{ #category : #testing }
SnakesAndLadders >> lastPosition [
	^ squares size
]

{ #category : #playing }
SnakesAndLadders >> playOneMove [
	| result |
	self assert: self invariant.
	^ self isOver 
		ifTrue: ['The game is over!']
		ifFalse: 
			[result := (self currentPlayer moveWith: die) , self checkResult.
			self upDateTurn.
			result]
]

{ #category : #playing }
SnakesAndLadders >> playToEnd [
	"SnakesAndLadders example playToEnd"
	Transcript open.
	Transcript
		show: self asString;
		cr;
		cr.
	[self isNotOver] whileTrue: 
			[Transcript
				show: self playOneMove asString;
				cr.
			Transcript
				show: self asString;
				cr;
				cr]
]

{ #category : #accessors }
SnakesAndLadders >> players [
	"needed for testing"
	^ players
]

{ #category : #printing }
SnakesAndLadders >> printOn: aStream [
	squares do: [:each | each printOn: aStream].
]

{ #category : #'initialize-release' }
SnakesAndLadders >> reset [
	die := Die new.
	turn := 1.
	over := false.
	players do: [:each | each moveTo: self firstSquare ].
	self assert: self invariant.
]

{ #category : #accessors }
SnakesAndLadders >> setDie: aDie [
	"For testing only. Can play the game with a loaded die."
	die := aDie.
]

{ #category : #testing }
SnakesAndLadders >> turn [
	^ turn
]

{ #category : #playing }
SnakesAndLadders >> upDateTurn [
	turn := 1 + (turn\\players size).
]
