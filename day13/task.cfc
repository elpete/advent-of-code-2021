component extends="AdventOfCodeTask" {

	function partOne() {
		var coordsAndInstructions = getCoordsAndInstructions( getPuzzleInput() ) 
		print.line( coordsAndInstructions.coords.len() );
		var finalCoords = processInstructions( coordsAndInstructions.coords, coordsAndInstructions.instructions.slice( 1, 1 ) );
		print.line( finalCoords.len() );
	}

	function partTwo() {
		var coordsAndInstructions = getCoordsAndInstructions( getPuzzleInput() ) 
		print.line( coordsAndInstructions.coords.len() );
		var finalCoords = processInstructions( coordsAndInstructions.coords, coordsAndInstructions.instructions );
		printAsGrid( finalCoords );
	}

	public array function processInstructions( required array coords, required array instructions ) {
		for ( var instruction in instructions ) {
			print.white( "Processing instruction: " ).blueLine( instruction );
			var parsedInstruction = parseInstruction( instruction );
			print.line( parsedInstruction );
			for ( var coord in arguments.coords ) {
				if ( parsedInstruction.axis == "y" ) {
					if ( coord[ 2 ] > parsedInstruction.pos ) {
						coord[ 2 ] =  parsedInstruction.pos - ( coord[ 2 ] - parsedInstruction.pos );
					}
				} else {
					if ( coord[ 1 ] > parsedInstruction.pos ) {
						coord[ 1 ] =  parsedInstruction.pos - ( coord[ 1 ] - parsedInstruction.pos );
					}
				}
			}
			arguments.coords = unique( arguments.coords ); 
			print.line();
		}
		return arguments.coords;
	}

	public struct function parseInstruction( required string instruction ) {
		var parts = replaceNoCase( arguments.instruction, "fold along ", "" ).trim().listToArray( "=" );
		return { "axis": parts[ 1 ], "pos": parts[ 2 ] };
	}

	function getCoordsAndInstructions( required string input ) {
		var parts = arraySlice( arguments.input.split( "\n\n" ), 1 )
			.map( ( part ) => {
				return arraySlice( replace( part, "\n", chr( 10 ), "all" ).split( "\n" ), 1 );
			} );
		return {
			"coords": parts[ 1 ].map( ( l ) => l.listToArray( "," ) ),
			"instructions": parts[ 2 ]
		}
	}

	private array function unique( required array coords ) {
		return arraySlice(
			createObject( "java", "java.util.HashSet" )
				.init( arguments.coords.map( ( coord ) => coord.toList( "," ) ) ).toArray(),
			1
		).map( ( coord ) => coord.listToArray( "," ) );
	}

	private void function printAsGrid( required array coords ) {
		var grid = createGrid( arguments.coords );
		populateGrid( grid, arguments.coords );
		print.line(
			grid.map( ( row ) => row.toList( "" ) ).toList( chr( 10 ) )
		);
	}

	private array function createGrid( required array coords ) {
		var maxX = arguments.coords.map( ( coord ) => coord[ 1 ] ).max() + 1;
		var maxY = arguments.coords.map( ( coord ) => coord[ 2 ] ).max() + 1;
		var grid = [];
		for ( var y = 1; y <= maxY; y++ ) {
			var row = [];
			for ( var x = 1; x <= maxX; x++ ) {
				row.append( "." );
			}
			grid.append( row );
		}
		return grid;
	}

	private void function populateGrid( required array grid, required array coords ) {
		for ( var coord in arguments.coords ) {
			arguments.grid[ coord[ 2 ] + 1 ][ coord[ 1 ] + 1 ] = "##";
		}
	}

// 	function getPuzzleInput() {
// 		return "6,10
// 0,14
// 9,10
// 0,3
// 10,4
// 4,11
// 6,0
// 6,12
// 4,1
// 0,13
// 10,12
// 3,4
// 3,0
// 8,4
// 1,10
// 2,14
// 8,10
// 9,0

// fold along y=7
// fold along x=5";
// 	}

}
