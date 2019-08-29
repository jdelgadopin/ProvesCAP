"
Play a rigged game and check the results.
"
Class {
	#name : #SnakesAndLaddersTest,
	#superclass : #TestCase,
	#instVars : [
		'eg',
		'loadedDie',
		'jack',
		'jill'
	],
	#category : #'Examples-SnakesAndLadders'
}

{ #category : #running }
SnakesAndLaddersTest >> example [
	^ SnakesAndLadders example
]

{ #category : #running }
SnakesAndLaddersTest >> setUp [
	eg := self example.
	loadedDie := LoadedDie new.
	eg setDie: loadedDie.
	jack := eg players first.
	jill := eg players last.
]

{ #category : #running }
SnakesAndLaddersTest >> testExample [
	self assert: eg currentPlayer = jack.
	loadedDie roll: 1.
	eg playOneMove.
	self assert: jack position = 6.
	self assert: eg currentPlayer = jill.
	loadedDie roll: 5.
	eg playOneMove.
	self assert: jill position = 1.
	self assert: eg currentPlayer = jack.
	loadedDie roll: 5.
	eg playOneMove.
	self assert: jack position = 5.
	self assert: eg currentPlayer = jill.
	loadedDie roll: 4.
	eg playOneMove.
	self assert: jill position = 1.
	self assert: eg currentPlayer = jack.
	loadedDie roll: 6.
	eg playOneMove.
	self assert: jack position = 5.
	self assert: eg currentPlayer = jill.
	loadedDie roll: 6.
	eg playOneMove.
	self assert: jill position = 9.
	self assert: eg currentPlayer = jack.
	loadedDie roll: 5.
	eg playOneMove.
	self assert: jack position = 10.
	self assert: eg currentPlayer = jill.
	loadedDie roll: 5.
	eg playOneMove.
	self assert: jill position = 1.
	self assert: eg currentPlayer = jack.
	loadedDie roll: 2.
	eg playOneMove.
	self assert: jack position = 12.
	self assert: eg isOver
]

{ #category : #running }
SnakesAndLaddersTest >> testStartPosition [
	self assert: eg lastPosition = 12.
	self assert: eg isNotOver.
	self assert: eg currentPlayer = jack.
	self assert: eg firstSquare isFirstSquare.
	self assert: eg firstSquare isLastSquare not.
	self assert: eg firstSquare position = 1.
	self assert: eg firstSquare isOccupied.
	self assert: (eg at: eg lastPosition) isFirstSquare not.
	self assert: (eg at: eg lastPosition) isLastSquare.
	self assert: (eg at: eg lastPosition) position = 12.
	self assert: (eg at: eg lastPosition) isOccupied not.
	self assert: jack name = 'Jack'.
	self assert: jill name = 'Jill'.
	self assert: jack position = 1.
	self assert: jill position = 1
]
