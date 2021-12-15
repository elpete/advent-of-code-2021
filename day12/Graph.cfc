component accessors="true" {

    property name="vertices" type="array";
    property name="adjacent" type="struct";
    property name="edges" type="numeric";
    property name="smallCaves" type="array";

    public Graph function init() {
        variables.vertices = [];
        variables.adjacent = {};
        variables.edges = 0;
        variables.smallCaves = [];

        return this;
    }

	public Graph function addVertex( v ) {
		if ( variables.vertices.contains( v ) ) {
            return this;
        }
		
        variables.vertices.append( v );

		variables.adjacent[ v ] = [];
        
        if ( isSmallCave( v ) ) {
			variables.smallCaves.append( v );
        }

        return this;
	}

	public Graph function addEdge(v, w) {
		if ( !variables.vertices.contains( v ) ) {
			addVertex( v );
		}
		if ( !variables.vertices.contains( w ) ) {
			addVertex( w );
		}

		variables.adjacent[ v ].append( w );
		variables.adjacent[ w ].append( v );
		variables.edges++;

        return this;
	}

    public any function searchOne(
        required string start,
        required string end,
        array path = [ arguments.start ],
        array finalPaths = []
    ) {
		for ( var i = 1; i <= variables.adjacent[ start ].len(); i++ ) {
			var cave = variables.adjacent[ start ][ i ];
			
            if ( !isLowercase( cave ) || !arguments.path.contains( cave ) ) {
                var newPath = duplicate( arguments.path );
				newPath.append( cave );

				if ( cave == "end" ) {
					arguments.finalPaths.append( newPath );
				} else {
					searchOne( cave, arguments.end, newPath, arguments.finalPaths );
				}
            }
		}

		return finalPaths.len();
    }

    public any function search(
        required string start,
        required string end,
        array path = [ arguments.start ],
        array finalPaths = [],
        any print
    ) {
		for ( var i = 1; i <= variables.adjacent[ start ].len(); i++ ) {
			var cave = variables.adjacent[ start ][ i ];

            if (
				(
                    isSmallCave( cave ) &&
                    caveHasBeenVisited( arguments.path, cave ) &&
                    checkForDoubledSmallCaves( arguments.path )
                ) ||
				(
                    isStartOrEndCave( cave ) &&
                    caveHasBeenVisited( arguments.path, cave )
                )
			) {
				continue;
			}

            var newPath = duplicate( arguments.path );
			newPath.append( cave );

			if ( cave == "end" ) {
				finalPaths.append( newPath );
			} else {
				search( cave, arguments.end, newPath, arguments.finalPaths, arguments.print );
			}
		}

		return finalPaths.len();
    }

    private boolean function caveHasBeenVisited( required array path, required string cave ) {
        return !!arguments.path.contains( arguments.cave );
    }

    private boolean function checkForDoubledSmallCaves( required array path ) {
        for ( var i = 1; i <= arguments.path.len(); i++ ) {
			var c = arguments.path[ i ];
            if ( isSmallCave( c ) ) {
				var numCaves = arguments.path.filter( ( p ) => p == c ).len();
                if ( numCaves > 1 ) {
                    return true;
                }
			}
		}
		return false;
    }

    private boolean function isSmallCave( required string cave ) {
        return !isStartOrEndCave( arguments.cave ) && isLowercase( arguments.cave );
    }

    private boolean function isStartOrEndCave( required string cave ) {
        return arguments.cave == "start" || arguments.cave == "end";
    }

    private boolean function isLowercase( required string s ) {
        return compare( lcase( arguments.s ), arguments.s ) == 0;
    }

    private boolean function arrayEquals( required array a, required array b ) {
        if ( arguments.a.len() != arguments.b.len() ) {
            return false;
        }

        for ( var i = 1; i <= arguments.a.len(); i++ ) {
            if ( arguments.a[ i ] != arguments.b[ i ] ) {
                return false;
            }
        }

        return true;
    }

}