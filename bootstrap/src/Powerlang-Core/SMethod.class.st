Class {
	#name : #SMethod,
	#superclass : #SScript,
	#category : #'Powerlang-Core-SExpressions'
}

{ #category : #visiting }
SMethod >> acceptVisitor: visitor [
	^visitor visitMethod: self
]

{ #category : #testing }
SMethod >> isMethod [
	^true
]

{ #category : #printing }
SMethod >> printOn: aStream indent: anInteger [
	aStream nextPutAll: '{MethodId. '; cr.
	super printOn: aStream indent: anInteger.
	aStream nextPutAll: '}'
]