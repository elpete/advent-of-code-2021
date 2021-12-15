component extends="AdventOfCodeTask" {

	function partOne( numeric daysToSimulate = 80 ) {
		var lanternfish = getPuzzleInput().listToArray();
		for ( var day = 1; day <= arguments.daysToSimulate; day++ ) {
			var currentFishCount = lanternfish.len();
			for ( var j = 1; j <= currentFishCount; j++ ) {
				if ( lanternfish[ j ] <= 0 ) {
					lanternfish[ j ] = 6;
					lanternfish.append( 8 );
				} else {
					lanternfish[ j ]--;
				}
			}
		}
		print.greenLine( lanternfish.len() );
	}

	function partTwo( numeric daysToSimulate = 256 ) {
		var lanternfishMap = getPuzzleInput().listToArray().reduce( ( map, age ) => {
			map[ trim( age ) ]++;
			return map;
		}, newAgeMap() );
		for ( var day = 1; day <= arguments.daysToSimulate; day++ ) {
			var lanternfishMapForDay = newAgeMap();
			for ( var nextAge = 7; nextAge >= 0; nextAge-- ) {
				if ( nextAge <= 0 ) {
					lanternfishMapForDay[ 8 ] = lanternfishMap[ 0 ];
					lanternfishMapForDay[ 6 ] = lanternfishMapForDay[ 6 ] + lanternfishMap[ 0 ];
				}
				lanternfishMapForDay[ nextAge ] = lanternfishMap[ nextAge + 1 ];
			}
			lanternfishMap = lanternfishMapForDay;
		}
		print.greenLine( lanternfishMap.valueArray().sum() );
	}

	function newAgeMap() {
		return {
			"0": 0,
			"1": 0,
			"2": 0,
			"3": 0,
			"4": 0,
			"5": 0,
			"6": 0,
			"7": 0,
			"8": 0,
		};
	}

	// function getPuzzleInput() {
	// 	return "3,4,3,1,2";
	// }

}
