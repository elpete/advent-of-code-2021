component extends="AdventOfCodeTask" {

	function partOne() {
		var caves = getPuzzleInputAsArray().map( ( l ) => l.listToArray( "-" ) );
		var graph = new Graph();
		for ( var cave in caves ) {
			graph.addEdge( cave[ 1 ], cave[ 2 ] );
		}
		var answer = graph.searchOne( "start", "end" );
		print.line( answer );
	}

	function partTwo() {
		var caves = getPuzzleInputAsArray().map( ( l ) => l.listToArray( "-" ) );
		var graph = new Graph();
		for ( var cave in caves ) {
			graph.addEdge( cave[ 1 ], cave[ 2 ] );
		}
		var answer = graph.search( start = "start", end = "end", print = print );
		print.line( answer );
	}

// 	function getPuzzleInput() {
// 		return "start-A
// start-b
// A-c
// A-b
// b-d
// A-end
// b-end
// ";
// 	}

}
