component extends="AdventOfCodeTask" {

	variables.syntaxErrorScoreMap = {
		")": 3,
		"]": 57,
		"}": 1197,
		">": 25137
	};

	variables.completionScoreMap = {
		")": 1,
		"]": 2,
		"}": 3,
		">": 4
	};

	variables.charMatchesMap = {
		"(": ")",
		")": "(",
		"{": "}",
		"}": "{",
		"[": "]",
		"]": "[",
		"<": ">",
		">": "<"
	};

	variables.openingChars = [ "(", "[", "{", "<" ];
	variables.closingChars = [ ")", "]", "}", ">" ];

	function partOne() {
		var syntaxErrorScore = getPuzzleInputAsArray()
			.map( parseLine )
			.filter( ( c ) => c != "" )
			.map( ( c ) => variables.syntaxErrorScoreMap[ c ] )
			.sum()
		print.line( syntaxErrorScore );
	}

	function partTwo() {
		var completionScores = getPuzzleInputAsArray()
			.filter( isIncompleteLine )
			.map( generateCompletionString )
			.map( scoreCompletionString );
		completionScores.sort( "numeric" );
		var middleScore = completionScores[ ceiling( completionScores.len() / 2 ) ];
		print.line( middleScore );
	}

	private string function parseLine( required string line ) {
		var openingChunkChars = [];
		for ( var i = 1; i <= arguments.line.len(); i++ ) {
			var currentChar = arguments.line[ i ];
			if ( variables.openingChars.contains( currentChar ) ) {
				openingChunkChars.append( currentChar );
			} else {
				var lastOpenedChunkChar = openingChunkChars.pop();
				var expectedMatchingChar = variables.charMatchesMap[ lastOpenedChunkChar ];
				if ( expectedMatchingChar != currentChar ) {
					print.redLine( "Syntax error at position #i#: Expected #expectedMatchingChar#, but found #currentChar# instead." );
					return currentChar;
				}
			}
		}
		return "";
	}

	private boolean function isIncompleteLine( required string line ) {
		var openingChunkChars = [];
		for ( var i = 1; i <= arguments.line.len(); i++ ) {
			var currentChar = arguments.line[ i ];
			if ( variables.openingChars.contains( currentChar ) ) {
				openingChunkChars.append( currentChar );
			} else {
				var lastOpenedChunkChar = openingChunkChars.pop();
				var expectedMatchingChar = variables.charMatchesMap[ lastOpenedChunkChar ];
				if ( expectedMatchingChar != currentChar ) {
					return false;
				}
			}
		}
		return !openingChunkChars.isEmpty();
	}

	private string function generateCompletionString( required string line ) {
		var openingChunkChars = [];
		for ( var i = 1; i <= arguments.line.len(); i++ ) {
			var currentChar = arguments.line[ i ];
			if ( variables.openingChars.contains( currentChar ) ) {
				openingChunkChars.append( currentChar );
			} else {
				var lastOpenedChunkChar = openingChunkChars.pop();
				var expectedMatchingChar = variables.charMatchesMap[ lastOpenedChunkChar ];
				if ( expectedMatchingChar != currentChar ) {
					error( "CORRUPTED LINE! Syntax error at position #i#: Expected #expectedMatchingChar#, but found #currentChar# instead." );
				}
			}
		}

		return openingChunkChars
			.reverse()
			.map( ( c ) => variables.charMatchesMap[ c ] )
			.toList( "" );
	}

	public numeric function scoreCompletionString( required string completionString ) {
		return arguments.completionString.listToArray( "" ).reduce( ( score, c ) => {
			arguments.score *= 5;
			arguments.score += variables.completionScoreMap[ arguments.c ];
			return score;
		}, 0 );
	}

// 	function getPuzzleInput() {
// 		return "[({(<(())[]>[[{[]{<()<>>
// [(()[<>])]({[<{<<[]>>(
// {([(<{}[<>[]}>{[]{[(<()>
// (((({<>}<{<{<>}{[]{[]{}
// [[<[([]))<([[{}[[()]]]
// [{[{({}]{}}([{[{{{}}([]
// {<[[]]>}<{[{[{[]{()[[[]
// [<(<(<(<{}))><([]([]()
// <{([([[(<>()){}]>(<<{{
// <{([{{}}[<[[[<>{}]]]>[]]
// ";
// 	}

}
