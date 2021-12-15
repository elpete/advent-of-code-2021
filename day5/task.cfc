component extends="AdventOfCodeTask" {

	function partOne() {
		var lineInstrutions = getPuzzleInputAsArray()
			.map( ( instruction ) => {
				// parse the instruction into arrays
				return instruction.listToArray( " -> " )
					.map( ( coordinateString ) => coordinateString.listToArray() );
			} )
			.filter( ( instruction ) => {
				// filter out points that are not a straight horizontal or vertical line
				return instruction[ 1 ][ 1 ] == instruction[ 2 ][ 1 ] ||
					instruction[ 1 ][ 2 ] == instruction[ 2 ][ 2 ];
			} )
			.map( ( instruction ) => {
				// explode the line out to all its points
				var points = [];
				if ( instruction[ 1 ][ 1 ] == instruction[ 2 ][ 1 ] ) {
					// x is static
					var start = min( instruction[ 1 ][ 2 ], instruction[ 2 ][ 2 ] );
					var end = max( instruction[ 1 ][ 2 ], instruction[ 2 ][ 2 ] );
					for ( var i = start; i <= end; i++ ) {
						points.append( [ instruction[ 1 ][ 1 ], i ] );
					}
				} else {
					// y is static
					var start = min( instruction[ 1 ][ 1 ], instruction[ 2 ][ 1 ] );
					var end = max( instruction[ 1 ][ 1 ], instruction[ 2 ][ 1 ] );
					for ( var i = start; i <= end; i++ ) {
						points.append( [ i, instruction[ 1 ][ 2 ] ] );
					}
				}

				return points.map( ( point ) => point.toList() );
			} )
			.reduce( ( pointMap, points ) => {
				for ( var point in points ) {
					if ( !pointMap.keyExists( point ) ) {
						pointMap[ point ] = 0;
					}
					pointMap[ point ]++;
				}
				return pointMap;
			}, {} )
			.filter( ( point, count ) => {
				return count >= 2;
			} );
		print.greenLine( lineInstrutions.len() );
	}

	function partTwo() {
		var lineInstrutions = getPuzzleInputAsArray()
			.map( ( instruction ) => {
				// parse the instruction into arrays
				return instruction.listToArray( " -> " )
					.map( ( coordinateString ) => coordinateString.listToArray() );
			} )
			.map( ( instruction ) => {
				// explode the line out to all its points
				var points = [];
				if ( instruction[ 1 ][ 1 ] == instruction[ 2 ][ 1 ] ) {
					// x is static
					var start = min( instruction[ 1 ][ 2 ], instruction[ 2 ][ 2 ] );
					var end = max( instruction[ 1 ][ 2 ], instruction[ 2 ][ 2 ] );
					for ( var i = start; i <= end; i++ ) {
						points.append( [ instruction[ 1 ][ 1 ], i ] );
					}
				} else if ( instruction[ 1 ][ 2 ] == instruction[ 2 ][ 2 ] ) {
					// y is static
					var start = min( instruction[ 1 ][ 1 ], instruction[ 2 ][ 1 ] );
					var end = max( instruction[ 1 ][ 1 ], instruction[ 2 ][ 1 ] );
					for ( var i = start; i <= end; i++ ) {
						points.append( [ i, instruction[ 1 ][ 2 ] ] );
					}
				} else {
					// diagonal line
					var xDirection = instruction[ 1 ][ 1 ] > instruction[ 2 ][ 1 ] ? -1 : 1;
					var yDirection = instruction[ 1 ][ 2 ] > instruction[ 2 ][ 2 ] ? -1 : 1;
					var diff = abs( instruction[ 1 ][ 1 ] - instruction[ 2 ][ 1 ] ) + 1;
					for ( var i = 0; i < diff; i++ ) {
						points.append( [ abs( instruction[ 1 ][ 1 ] + ( xDirection * i ) ), abs( instruction[ 1 ][ 2 ] + ( yDirection * i ) ) ] );
					}
				}

				return points.map( ( point ) => point.toList() );
			} )
			.reduce( ( pointMap, points ) => {
				for ( var point in points ) {
					if ( !pointMap.keyExists( point ) ) {
						pointMap[ point ] = 0;
					}
					pointMap[ point ]++;
				}
				return pointMap;
			}, {} )
			.filter( ( point, count ) => {
				return count >= 2;
			} );
		print.greenLine( lineInstrutions.len() );
	}

// 	function getPuzzleInput() {
// 		return "0,9 -> 5,9
// 8,0 -> 0,8
// 9,4 -> 3,4
// 2,2 -> 2,1
// 7,0 -> 7,4
// 6,4 -> 2,0
// 0,9 -> 2,9
// 3,4 -> 1,4
// 0,0 -> 8,8
// 5,5 -> 8,2";
// 	}

}
