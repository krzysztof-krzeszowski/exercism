def to_rna(a):
    d = {'C': 'G', 'G': 'C', 'T': 'A', 'A': 'U'}
    a = list(a)
    for i, l in enumerate(a):
        if l not in d.keys():
            return ''
        a[i] = d[a[i]]
    return ''.join(a)
