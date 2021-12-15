component extends="AdventOfCodeTask" {

	function partOne() {
		var position = getPuzzleInputAsArray().reduce( ( pos, instruction ) => {
			var action = listFirst( instruction, " " );
			var amount = listLast( instruction, " " );
			switch ( action ) {
				case "forward":
					return [ pos[ 1 ] + amount, pos[ 2 ] ];
				case "up":
					return [ pos[ 1 ], pos[ 2 ] - amount ];
				case "down":
					return [ pos[ 1 ], pos[ 2 ] + amount ];
			}
		}, [ 0, 0 ] );
		print.greenLine( position[ 1 ] * position[ 2 ] );
	}

	function partTwo() {
		var position = getPuzzleInputAsArray().reduce( ( pos, instruction ) => {
			var action = listFirst( instruction, " " );
			var amount = listLast( instruction, " " );
			switch ( action ) {
				case "forward":
					pos.horizontal += amount;
					pos.depth += (amount * pos.aim);
					return pos;
				case "up":
					pos.aim -= amount;
					return pos;
				case "down":
					pos.aim += amount;
					return pos;
			}
		}, { horizontal: 0, depth: 0, aim: 0 } );
		print.greenLine( position.horizontal * position.depth );
	}

// 	function getPuzzleInput() {
// 		return "forward 5
// down 5
// forward 8
// up 3
// down 8
// forward 2";
// 	}

}
