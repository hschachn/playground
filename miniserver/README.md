# miniserver


`miniserver.py`

Starts minimal web server, listening at port 45678 for requests to calculate Fibonacci numbers.
Requests are processed asynchronously.

Example:   `GET http://localhost:45678/fib/34`

`miniclient.py`

Client starting a fixed number of requests to the locally running *miniserver*.
A thread is created for each request.
