"
A Binding is .

"
Class {
	#name : #Binding,
	#superclass : #Association,
	#category : #DeutschByte
}

{ #category : #testing }
Binding class >> exampleSuccessful [
	"Binding exampleSuccessful"

	#testingDynamicBinding bindTo: 'This is a test' in: 
		[ Transcript show: (#testingDynamicBinding binding) asString; cr. ] .
]

{ #category : #testing }
Binding class >> exampleUnsuccessful [
	"Binding exampleUnsuccessful"

	#testingDynamicBinding bindTo: 'This is a test' in: 
	[ Transcript show: (#testingDynamikBinding binding) asString; cr. ] .
]

{ #category : #'instance creation' }
Binding class >> of: aSymbol to: aValue in: aBlock [
	^ self new of: aSymbol to: aValue in: aBlock 
]

{ #category : #'initialize-release' }
Binding >> of: aSymbol to: aValue in: aBlock [
	key := aSymbol.
	value := aValue.
	^ aBlock value
]
