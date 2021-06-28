import socket
import logging

PORT=8977

logging.basicConfig(
	level=logging.DEBUG,
	format='%(asctime)s %(name)-8s %(levelname)-8s %(message)s',
	datefmt='%m-%d %H:%M',
	filename='courier.log')

def is_valid_ip(ip: str) -> bool:
	try:
		socket.inet_aton(ip)
		return True
	except socket.error:
		return False

class logger:
	@staticmethod
	def _log(*args, mode=logging.info):
		mode(" ".join([str(i) for i in args]))

	@staticmethod
	def log(*args):
		logger._log(*args)
		
	@staticmethod
	def debug(*args):
		logger._log(*args, mode=logging.debug)

	@staticmethod
	def error(*args):
		logger._log(*args, mode=logging.error)

	@staticmethod
	def warn(*args):
		logger._log(*args, mode=logging.warning)