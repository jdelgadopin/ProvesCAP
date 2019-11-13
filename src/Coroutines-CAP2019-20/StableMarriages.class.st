"
Solving the Stable Marriages problem with coroutines, according to: ""Stable Marriages by Coroutines""
Lloyd Allison
Information Processing Letters 16 (1983), 61-65 

"
Class {
	#name : #StableMarriages,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'main',
		'men',
		'women',
		'numberOfCouples',
		'result'
	],
	#category : #'Coroutines-CAP2019-20-StableMarriages'
}

{ #category : #'instance creation' }
StableMarriages class >> withRandomPreferences: anInteger [
	"StableMarriages withRandomPreferences: anInteger"
	^ (self new) numberOfCouples: anInteger; 
				randomInitialization.
				
]

{ #category : #accessing }
StableMarriages >> numberOfCouples: anInteger [
	numberOfCouples := anInteger
	
]

{ #category : #initialization }
StableMarriages >> randomInitialization [
	"men and women preferences are initialized at random"
	
	result := Array new: numberOfCouples.

	men := Array new: numberOfCouples.
	women := Array new: numberOfCouples.

	numberOfCouples notNil 
		ifTrue: [
			main := Coroutine maker: [ :resume :value | 
											1 to: numberOfCouples do: [ :i | resume value: (men at: i) value: nil ]]. 
			1 to: numberOfCouples do: [ :index | 
					men at: index put: (Coroutine maker: [ :resume :value | 
													| prefs |
													prefs := (1 to: numberOfCouples) asArray shuffled.
													1 to: numberOfCouples do: [ :i | resume value: (women at: (prefs at: i)) value: index] ]).
					women at: index put:  (Coroutine maker: [ :resume :value | 
													| prefs newProposal jilt |
													prefs := (1 to: numberOfCouples) asArray shuffled.
													result at: index put: value.
													newProposal := resume value: main value: nil.
													[ true ] whileTrue: [
																(prefs at: newProposal) < (prefs at: (result at: index)) 
																	ifTrue: [ 	jilt := result at: index.
																			  	result at: index put: newProposal.
																				newProposal := resume value: (men at: jilt) value: nil ]
																	ifFalse: [ newProposal := resume value: (men at: newProposal) value: nil ]]])]]
]

{ #category : #computation }
StableMarriages >> value [

	main value: nil.
	^ result
]
