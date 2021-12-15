component extends="AdventOfCodeTask" {

	function partOne() {
		var positions = getPuzzleInput().listToArray().map( ( pos ) => parseNumber( pos.trim() ) );
		var cheapestAlignment = nullValue();
		var cheapestFuelCost = nullValue();
		for ( var align = positions.min(); align <= positions.max(); align++ ) {
			var fuelCost = positions.map( ( pos ) => abs( align - pos ) ).sum();
			if ( isNull( cheapestFuelCost ) || fuelCost < cheapestFuelCost ) {
				cheapestAlignment = align;
				cheapestFuelCost = fuelCost;
			}
		}
		if ( isNull( cheapestAlignment ) ) {
			print.line( "Something went wrong" );
			return;
		}
		print.line( cheapestAlignment );
		print.line( cheapestFuelCost );
	}

	function partTwo() {
		var positions = getPuzzleInput().listToArray().map( ( pos ) => parseNumber( pos.trim() ) );
		var cheapestAlignment = nullValue();
		var cheapestFuelCost = nullValue();
		for ( var align = positions.min(); align <= positions.max(); align++ ) {
			var fuelCost = positions.map( ( pos ) => {
				var distance = abs( align - pos );
				return ( ( distance * distance ) + distance ) / 2;
			} ).sum();
			if ( isNull( cheapestFuelCost ) || fuelCost < cheapestFuelCost ) {
				cheapestAlignment = align;
				cheapestFuelCost = fuelCost;
			}
		}
		if ( isNull( cheapestAlignment ) ) {
			print.line( "Something went wrong" );
			return;
		}
		print.line( cheapestAlignment );
		print.line( cheapestFuelCost );
	}

	// function getPuzzleInput() {
	// 	return "16,1,2,0,4,2,7,1,2,14";
	// }

}
