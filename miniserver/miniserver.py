__author__ = 'Hermann Schachner'

import logging
import concurrent.futures

from tornado.ioloop import IOLoop
from tornado.web import *
from tornado.options import options

options.define('port', type=int, default=45678, help="Port for mini server to listen at")
options.define('endpoint', default=r"/(\w+)(?:/(\w+))?", help="URL base path of API")

handlers = list()


def handler(method):
    handlers.append(method.__name__)

    def _inner(self, *args):
        method(self, *args)

    return _inner


def fib_gen(n_max):
    a, b, n = 0, 1, 0
    while n < n_max:
        yield b
        a, b, n = b, a + b, n + 1


def fibonacci(n):
    fg = fib_gen(n)
    value = 0
    logging.info("START F %d" % n)
    while True:
        try:
            value = next(fg)
        except StopIteration:
            logging.info("END  F %d" % n)
            return value

    return value


class MiniHandler(RequestHandler):
    @staticmethod
    def undefined_handler(*args):
        raise HTTPError(404)

    @handler
    def echo(self, *args):
        self.write({"parameters": list(args)})

    @handler
    def fib(self, *args):
        n = int(list(args)[0])

        self.write({'result': fibonacci(n)})

    @gen.coroutine
    def get(self, *args, **kwargs):
        (func, params) = (list(args)[0], list(args)[1:])

        default_handler = MiniHandler.undefined_handler
        _handler = getattr(self, func, default_handler)

        _handler = func in handlers and _handler or default_handler
        executor = concurrent.futures.ThreadPoolExecutor(max_workers=20)
        yield executor.submit(_handler, *params)

    def data_received(self, chunk):
        raise NotImplementedError()


class MiniServer(object):
    def __init__(self, *args, **kwargs):
        self.io_loop = IOLoop.current()

    def start(self, application_data=None):
        options.parse_command_line()
        logging.info("Starting mini server. Press Ctrl-Break or Ctrl-Pause to stop")
        logging.info("Listening at port %d." % options.port)
        logging.info("Using endpoint %s." % options.endpoint)

        url_handlers = list()
        url_handlers.append(url(options.endpoint, MiniHandler, dict()))

        _application = Application(url_handlers)
        _application.listen(options.port)

        self.io_loop.start()

        return True

    def stop(self):
        self.io_loop.stop()
        logging.info("Stopped %s" % options.appname)


if __name__ == "__main__":
    server = MiniServer()
    server.start()
