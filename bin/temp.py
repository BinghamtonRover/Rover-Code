from lib.network.generated import BurtLog, BurtLogLevel

log = BurtLog(title="hello", level=BurtLogLevel.critical)

print(log)
