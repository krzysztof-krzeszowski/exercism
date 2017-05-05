def is_pangram(a):
    import string
    a = a.lower()
    for l in string.ascii_lowercase:
        if l not in a:
            return False
    return True
