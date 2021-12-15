component extends="AdventOfCodeTask" {

	function partOne() {
		var heightMap = getPuzzleInputAsArray().map( ( row ) => row.trim().listToArray( "" ) );
		var lowPoints = [];
		for ( var i = 1; i <= heightMap.len(); i++ ) {
			var columnLen = heightMap[ i ].len();
			for ( var j = 1; j <= columnLen; j++ ) {
				if ( isLowPoint( heightMap, i, j ) ) {
					lowPoints.append( heightMap[ i ][ j ] );
				}
			}
		}
		var score = lowPoints.map( ( p ) => p + 1 ).sum();
		print.line( score );
	}

	public boolean function isLowPoint(
		required array heightMap,
		required numeric row,
		required numeric column
	) {
		var value = heightMap[ row ][ column ];

		// print.line( "row: #row#, column: #column# = #value#" );

		// 9's are never low points
		if ( value == 9 ) {
			// print.line( "Failed because it's a 9" ).line();
			return false;
		}

		// check to the left
		if ( column > 1 ) {
			if ( heightMap[ row ][ column - 1 ] <= value ) {
				// print.line( "Failed because left value (#heightMap[ row ][ column - 1 ]#) is lower" ).line();
				return false;
			}
		}

		// check to the right
		if ( column < heightMap[ row ].len() ) {
			if ( heightMap[ row ][ column + 1 ] <= value ) {
				// print.line( "Failed because right value (#heightMap[ row ][ column + 1 ]#) is lower" ).line();
				return false;
			}
		}

		// check above
		if ( row > 1 ) {
			if ( heightMap[ row - 1 ][ column ] <= value ) {
				// print.line( "Failed because top value (#heightMap[ row - 1 ][ column ]#) is lower" ).line();
				return false;
			}
		}

		// check below
		if ( row < heightMap.len() ) {
			if ( heightMap[ row + 1 ][ column ] <= value ) {
				// print.line( "Failed because bottom value (#heightMap[ row + 1 ][ column ]#) is lower" ).line();
				return false;
			}
		}

		// print.line( "Success!" );
		// print.line();

		return true;
	}

	function partTwo() {
		var grid = getPuzzleInputAsArray()
			.map( ( row, x ) => {
				return row.trim().listToArray( "" )
					.map( ( height, y ) => {
						// ignore 9's
						if ( height == 9 ) {
							return nullValue();
						}

						return {
							"height": height,
							"x": x,
							"y": y,
							"isInBasin": false
						};
				} );
			} );

		print.line( grid );

		/**
		 * Gets the point object at a specified location.
		 * If the location is out of bounds, then null is returned.
		 */
		var getPointAt = ( x, y ) => {
			if ( x < 1 || x > grid.len() ) {
				return nullValue();
			}

			var row = grid[ x ];
			
			if ( y < 1 || y > row.len() ) {
				return nullValue();
			}
			
			return isNull( row[ y ] ) ? nullValue() : row[ y ];
		};

		// Link points
		for ( var row in grid ) {
			for ( var point in row ) {
				// Skip excluded points (9's)
				if ( isNull( point ) ) {
					continue;
				}

				point.up = getPointAt( point.x, point.y + 1 );
				point.down = getPointAt( point.x, point.y - 1 );
				point.right = getPointAt( point.x + 1, point.y );
				point.left = getPointAt( point.x - 1, point.y );
			}
		}
		
		// Find all basins
		var basins = findAllBasins( grid );

		// Sort by size
		basins.sort( ( b1, b2 ) => b2.len() - b1.len() );

		// Get the largest 3 and compute the product
		var b0Size = basins[ 1 ].len();
		var b1Size = basins[ 2 ].len();
		var b2Size = basins[ 3 ].len();
		var result = b0Size * b1Size * b2Size;

		print.line( "Found [#basins.len()#] basins, the largest are [#b0Size#], [#b1Size#], and [#b2Size#]. The product is [#result#]." );
	}

	private array function mapBasin( required struct root ) {
		var basin = [];

		var mapBasinAt = ( point ) => {
			// Skip out-of-bounds, excluded points, and nodes that have already been processed.
			if ( isNull( point ) || point.isInBasin ) {
				return;
			}

			// Add to basin
			point.isInBasin = true;
			basin.append( point );

			// Add each neighbor
			mapBasinAt( point.up ?: nullValue() );
			mapBasinAt( point.right ?: nullValue() );
			mapBasinAt( point.down ?: nullValue() );
			mapBasinAt( point.left ?: nullValue() );
		}

		// Kick off flood fill from the first point
		mapBasinAt( root );

		return basin;
	}

	public array function findAllBasins( required array grid ) {
		var basins = [];

		// Try each point
		for ( var row in grid ) {
			for ( var point in row ) {
				// Skip nulls (9s that have been excluded)
				if ( isNull( point ) ) {
					continue;
				}

				// Skip points that are already in a basin
				if ( point.isInBasin ) {
					continue;
				}

				// We found a new basin
				basins.append( mapBasin( point ) );
			}
		}

		return basins;
	}

// 	function getPuzzleInput() {
// 		return "2199943210
// 3987894921
// 9856789892
// 8767896789
// 9899965678";
// 	}

}
