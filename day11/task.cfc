component extends="AdventOfCodeTask" {

	function partOne() {
		var octopuses = getPuzzleInputAsArray().map( ( line ) => line.listToArray( "" ).map( ( item ) => parseNumber( trim( item ) ) ) );
		var flashes = 0;
		var steps = 100;
		for ( var i = 1; i <= steps; i++ ) {
			flashes += step( octopuses );
		}
		print.line( flashes );
	}

	function partTwo() {
		var octopuses = getPuzzleInputAsArray().map( ( line ) => line.listToArray( "" ).map( ( item ) => parseNumber( trim( item ) ) ) );
		var totalOctopuses = octopuses.map( ( line ) => line.len() ).sum();
		print.line( totalOctopuses );
		var currentStep = 1;
		while ( currentStep <= 1000 ) {
			var flashes = step( octopuses );
			if ( flashes == totalOctopuses ) {
				print.line( "All octopuses flashed of Step ###currentStep#!" );
				return;
			}
			currentStep++;
		}
		print.redLine( "Timed out after #currentStep# steps" );
	}

	function step( required array octopuses ) {
		increaseBioluminescenceByOne( arguments.octopuses );
		var flashes = 0;
		var flashed = false;
		do {
			flashed = checkForFlashes( arguments.octopuses );
			if ( flashed ) {
				flashes++;
			}
		} while ( flashed );
		resetFlashedOctopusBioluminescence( arguments.octopuses );
		return flashes;
	}

	function increaseBioluminescenceByOne( required array octopuses ) {
		for ( var row = 1; row <= arguments.octopuses.len(); row++ ) {
			for ( var col = 1; col <= arguments.octopuses[ row ].len(); col++ ) {
				arguments.octopuses[ row ][ col ]++;
			}
		}
	}

	function checkForFlashes( required array octopuses ) {
		for ( var row = 1; row <= arguments.octopuses.len(); row++ ) {
			for ( var col = 1; col <= arguments.octopuses[ row ].len(); col++ ) {
				if ( arguments.octopuses[ row ][ col ] == 10 ) {
					flash( arguments.octopuses, row, col );
					return true;
				}
			}
		}
		return false;
	}

	function flash( required array octopuses, required numeric row, required numeric col ) {
		arguments.octopuses[ row ][ col ]++;
		
		tryIncrementingPosition( arguments.octopuses, arguments.row - 1, arguments.col - 1 ); // top left
		tryIncrementingPosition( arguments.octopuses, arguments.row - 1, arguments.col ); // top
		tryIncrementingPosition( arguments.octopuses, arguments.row - 1, arguments.col + 1 ); // top right
		tryIncrementingPosition( arguments.octopuses, arguments.row, arguments.col + 1 ); // right
		tryIncrementingPosition( arguments.octopuses, arguments.row + 1, arguments.col + 1 ); // bottom right
		tryIncrementingPosition( arguments.octopuses, arguments.row + 1, arguments.col ); // bottom
		tryIncrementingPosition( arguments.octopuses, arguments.row + 1, arguments.col - 1 ); // bottom left
		tryIncrementingPosition( arguments.octopuses, arguments.row, arguments.col - 1 ); // left
	}

	function tryIncrementingPosition( required array octopuses, required numeric row, required numeric col ) {
		if ( arguments.row >= 1 && arguments.row <= arguments.octopuses.len() ) {
			if ( arguments.col >= 1 && arguments.col <= arguments.octopuses[ arguments.row ].len() ) {
				if ( arguments.octopuses[ arguments.row ][ arguments.col ] < 10 ) {
					arguments.octopuses[ arguments.row ][ arguments.col ]++;
				}
			}
		}
	}

	function resetFlashedOctopusBioluminescence( required array octopuses ) {
		for ( var row = 1; row <= arguments.octopuses.len(); row++ ) {
			for ( var col = 1; col <= arguments.octopuses[ row ].len(); col++ ) {
				if ( arguments.octopuses[ row ][ col ] > 9 ) {
					arguments.octopuses[ row ][ col ] = 0;
				}
			}
		}
	}

	function padRight( required string s, numeric numChars = 3, string padChar = " " ) {
		arguments.s = toString( arguments.s );
		while ( arguments.s.len() < numChars ) {
			arguments.s &= arguments.padChar;
		}
		return arguments.s;
	}

	function printOctopuses( required array octopuses ) {
		print.line(
			octopuses.map( ( line ) => {
				return line.map( ( octopus ) => padRight( octopus ) ).toList( " " )
			} ).toList( chr( 10 ) )
		).line();

	}

// 	function getPuzzleInput() {
// 		return "5483143223
// 2745854711
// 5264556173
// 6141336146
// 6357385478
// 4167524645
// 2176841721
// 6882881134
// 4846848554
// 5283751526
// ";
// 	}

}
