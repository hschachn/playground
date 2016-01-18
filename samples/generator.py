"""Generator sample code"""

def get_counter( start ):

    def create_counter(ssa):
        s = ssa
        while True:
            yield s
            s = s + 1 

    _counter = create_counter(start)

    def _get_next():
        return next(_counter)

    return _get_next

counter = get_counter( 2 )

print ( counter() )
print ( counter() )
print ( counter() )
