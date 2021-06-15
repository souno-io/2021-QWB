import tqdm
import hashlib
import sys
import signal

import string
from random import SystemRandom
signal.alarm(10)
prefix = ''.join(SystemRandom().choice(string.ascii_letters + string.digits) for _ in range(10))
difficulty = 20
m = input(f"sha256({prefix}+?) startwith 0*{difficulty}: ").strip().encode()
if not bin(int.from_bytes(hashlib.sha256(prefix.encode()+m).digest(),'big'))[2:].zfill(256).startswith('0'*difficulty):
    exit()
signal.alarm(10)

p = 50008229300280272288750696693443237206510149742681893621568371010746153190851
F = GF(p)
n = 38586596682315024914159488189385213893888456355356257828798596650594147747
A = matrix([F(10296659894950355251590567112643545978510897585442356689705061456458797931312),F(35003341641318468754490199823357317965813703109770661789508283786256183274648)])
Fn = GF(n)

try:
    w = int(input("Input w:"))
    assert w > 0 and w < 10
except:
    w = 7

def do_iter(A,C):
    B=matrix([-A[0,0],A[0,1]])
    A=A/((A*A.T[::-1,:]*C*C.T[::-1,:]+1)[0,0])
    B=B/((B*B.T[::-1,:]*C*C.T[::-1,:]+1)[0,0])
    D=matrix([A.T[::-1,:].T[0],B[0]])
    E=C*D.T
    return E

def fan(k, w, A):
    B = matrix([0,1])
    k = int(k)
    if k != 0:
        assert k > 0
        for i in tqdm.tqdm(range(ceil(log(k,2))+1), file=sys.stdout):
            if k % 2 == 1:
                lookup = [matrix([0,1])]
                for m in range(2^w):
                    lookup.append(do_iter(A,lookup[-1]))
                lookup[-1] = matrix([-lookup[-1][0,0], lookup[-1][0,1]])
                for m in range(2^w-1):
                    lookup.append(do_iter(A,lookup[-1]))
                m = k % (2^(w+1))
                if m >= 2^w:
                    m -= 2^(w+1)
                k -= m
                B = do_iter(B,lookup[m])
            k = k/2
            A = do_iter(A,A)
    return B

def matrix_sign(d, m):
    k = Fn('0x' + hashlib.sha256(m+int(d).to_bytes(32,"big")).hexdigest())
    print("Signing message:")
    a = Fn(fan(k,w,A)[0,0])*d
    e = Fn('0x' + hashlib.sha256(m).hexdigest())
    return (a*k/(e+a)/d, k/(e+a))

def matrix_verify(B, m, a, b):
    if a == 0 or b == 0:
        return False
    e = Fn('0x' + hashlib.sha256(m).hexdigest())
    print("Verifying sig 1/2:")
    C = fan(a,w,B)
    print("Verifying sig 2/2:")
    D = fan(e*b,w,A)
    return Fn(do_iter(C,D)[0,0]) == a/b

d = Fn.random_element()
print("Generating Matrix B:")
B = fan(d,w,A)
print(B)

msgs = set()
while True:
    signal.alarm(10)
    m = input("Command/Message: ").strip()
    if m == "flag":
        a = Fn(input("a: ").strip())
        b = Fn(input("b: ").strip())
        if matrix_verify(B, b"flag", a, b):
            print(open("flag.txt","r").read())
        else:
            print("Wrong!")
    elif m == "verify":
        m = input("Message: ").strip()
        a = Fn(input("a: ").strip())
        b = Fn(input("b: ").strip())
        print(matrix_verify(B, m.encode(), a, b))
    else:
        msgs.add(m)
        if len(msgs) > 8:
            print("The more you want, the less you will get")
            break
        assert m.encode() != b"flag"
        print(matrix_sign(d, m.encode()))