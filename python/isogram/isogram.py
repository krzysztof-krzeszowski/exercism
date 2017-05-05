def is_isogram(a):
    import string

    a = list(a.lower())
    while a:
        l = a.pop()
        if l not in string.ascii_lowercase:
            continue
        elif l in a:
            return False
    return True
