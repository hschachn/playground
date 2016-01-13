

def get_counter():

    def create_counter():
        s = 1
        while True:
            yield s
            s = s + 1 

    _counter = create_counter()

    def _get_next():
        return next(_counter)

    return _get_next

counter = get_counter()

print ( counter() )
print ( counter() )
print ( counter() )
