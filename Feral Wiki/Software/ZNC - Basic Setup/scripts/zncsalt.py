import hashlib
import string

from random import SystemRandom

passvar = 'SETAPASS'

salt_chars = string.ascii_letters + string.digits
random = SystemRandom()
salt = "".join([random.choice(salt_chars) for i in range(20)])
print("sha256#{hash}#{salt}#".format(hash=hashlib.sha256((passvar+salt).encode('utf-8')).hexdigest(),
    salt=salt
))