component extends="AdventOfCodeTask" {

	function partOne() {
		var input = getPuzzleInput();
		var parts = input.split( "\n\n" );
		var picks = parts[ 1 ].listToArray();
		var boards = arraySlice( parts, 2 ).map( parseBoard );

		for ( var i = 1; i <= picks.len(); i++ ) {
			for ( var board in boards ) {
				var pickSlice = picks.slice( 1, i );
				if ( isBoardWinner( board, pickSlice ) ) {
					var lastPickedNumber = picks[ i ];
					print.line( "winner on draw #i# (#lastPickedNumber#)!" );
					var sumOfUnmarkedNumbersOnBoard = sumUnmarkedNumbers( board, pickSlice );
					print.line( "sum of all unmarked numbers for board: #sumOfUnmarkedNumbersOnBoard#" );
					print.white( "Board score: #sumOfUnmarkedNumbersOnBoard# x #lastPickedNumber# = " )
						.blueLine( sumOfUnmarkedNumbersOnBoard * lastPickedNumber );
					return;
				}
			}
		}
		print.line( "no winner!" );
	}
	
	function partTwo() {
		var input = getPuzzleInput();
		var parts = input.split( "\n\n" );
		var picks = parts[ 1 ].listToArray();
		var boards = arraySlice( parts, 2 ).map( parseBoard );
		var boardIndexesThatHaveWon = [];
		var lastWinningBoard = nullValue();
		var lastWinningPickIndex = nullValue();

		for ( var i = 1; i <= picks.len(); i++ ) {
			for ( var j = 1; j <= boards.len(); j++ ) {
				if ( boardIndexesThatHaveWon.contains( j ) ) {
					continue;
				}
				var board = boards[ j ];
				if ( isBoardWinner( board, picks.slice( 1, i ) ) ) {
					boardIndexesThatHaveWon.append( j );
					lastWinningBoard = board;
					lastWinningPickIndex = i;
				}
			}
		}

		if ( isNull( lastWinningBoard ) || isNull( lastWinningPickIndex ) ) {
			print.line( "no winner!" );
		}

		var lastPickedNumber = picks[ lastWinningPickIndex ];
		print.line( "winner on draw #lastWinningPickIndex# (#lastPickedNumber#)!" );
		var sumOfUnmarkedNumbersOnBoard = sumUnmarkedNumbers( lastWinningBoard, picks.slice( 1, lastWinningPickIndex ) );
		print.line( "sum of all unmarked numbers for board: #sumOfUnmarkedNumbersOnBoard#" );
		print.white( "Board score: #sumOfUnmarkedNumbersOnBoard# x #lastPickedNumber# = " )
			.blueLine( sumOfUnmarkedNumbersOnBoard * lastPickedNumber );
		return;
	}

	public array function parseBoard( string boardString ) {
		return arrayFlatten(
			arraySlice( arguments.boardString.split( "\n" ), 1 )
				.map( ( row ) => {
					return arraySlice( row.trim().split( "\s+" ), 1 );
				} )
		);
	}

	variables.winningIndexes = [
		[ 1, 2, 3, 4, 5 ],
		[ 6, 7, 8, 9, 10 ],
		[ 11, 12, 13, 14, 15 ],
		[ 16, 17, 18, 19, 20 ],
		[ 21, 22, 23, 24, 25 ],
		[ 1, 6, 11, 16, 21 ],
		[ 2, 7, 12, 17, 22 ],
		[ 3, 8, 13, 18, 23 ],
		[ 4, 9, 14, 19, 24 ],
		[ 5, 10, 15, 20, 25 ]
	];

	public boolean function isBoardWinner( required array board, required array picks ) {
		if ( arguments.picks.len() < 5 ) {
			return false;
		}

		var pickedIndexes = arguments.picks.map( ( pick ) => {
			return board.find( pick );
		} ).filter( ( pickedIndex ) => pickedIndex != 0 );
		
		if ( pickedIndexes.len() < 5 ) {
			return false;
		}

		for ( var winningIndex in variables.winningIndexes ) {
			var intersection = arrayIntersect( pickedIndexes, winningIndex );
			if ( intersection.len() == 5 ) {
				return true;
			}
		}

		return false;
	}

	public numeric function sumUnmarkedNumbers( board, picks ) {
		return board.filter( ( x ) => !picks.contains( x ) ).sum();
	}

	private array function arrayFlatten( required array arrayToFlatten ) {
		return arguments.arrayToFlatten.reduce( ( flattenedArray, innerArray ) => {
			flattenedArray.append( innerArray, true );
			return flattenedArray;
		}, [] );
	}

	private array function arrayIntersect( required array a, required array b ) {
		return arguments.a.reduce( ( matches, x ) => {
			if ( b.containsNoCase( x ) ) {
				matches.append( x );
			}
			return matches;
		}, [] );
	}

// 	function getPuzzleInput() {
// 		return "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

// 22 13 17 11  0
//  8  2 23  4 24
// 21  9 14 16  7
//  6 10  3 18  5
//  1 12 20 15 19

//  3 15  0  2 22
//  9 18 13 17  5
// 19  8  7 25 23
// 20 11 10 24  4
// 14 21 16 12  6

// 14 21 17 24  4
// 10 16 15  9 19
// 18  8 23 26 20
// 22 11 13  6  5
//  2  0 12  3  7";
// 	}

}
