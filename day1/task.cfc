component extends="AdventOfCodeTask" {

	function partOne() {
		var sonarReadings = getPuzzleInputAsArray();
		var increases = sonarReadings.map( ( currentValue, i ) => {
			// no change for the initial value
			if ( i == 1 ) {
				return 0;
			}

			var previousValue = sonarReadings[ i - 1 ];
			return previousValue < currentValue ? 1 : 0;
		} );
		var totalIncreases = increases.reduce( ( acc, x ) => acc + x, 0 );
		print.greenLine( totalIncreases );
	}

	function partTwo() {
		var sonarReadings = getPuzzleInputAsArray();
		var windows = sonarReadings.map( ( currentValue, i ) => {
			// don't calculate windows for the first two values
			if ( i == 1 || i == 2 ) {
				return 0;
			}

			return currentValue + sonarReadings[ i - 1 ] + sonarReadings[ i - 2 ];
		} ).slice( 3 );
		var increases = windows.map( ( currentValue, i ) => {
			// no change for the initial value
			if ( i == 1 ) {
				return 0;
			}

			var previousValue = windows[ i - 1 ];
			return previousValue < currentValue ? 1 : 0;
		} );
		var totalIncreases = increases.reduce( ( acc, x ) => acc + x, 0 );
		print.greenLine( totalIncreases );
	}

// 	function getPuzzleInput() {
// 		return "199
// 200
// 208
// 210
// 200
// 207
// 240
// 269
// 260
// 263";
// 	}

}
