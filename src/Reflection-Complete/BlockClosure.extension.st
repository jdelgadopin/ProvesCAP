Extension { #name : #BlockClosure }

{ #category : #'*Reflection-Complete' }
BlockClosure >> whileTrueCC: aBlock [
	"versió de whileTrue: implementada amb callcc:"

	| cont |
	cont := Continuation callcc: [ :cc | cc ].
	self value
		ifTrue: [ aBlock value.
			       cont value: cont ]
		ifFalse: [ ^ nil ] 
]
