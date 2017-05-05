def distance(a, b):
    if len(a) != len(b):
        raise ValueError
    return sum([va != vb for (va, vb) in zip(a, b)])
