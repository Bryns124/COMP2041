def read_dna(dna_file):
    """
    Read a DNA string from a file.
    the file contains data in the following format:
    A <-> T
    G <-> C
    G <-> C
    C <-> G
    G <-> C
    T <-> A
    Output a list of touples:
    [
        ('A', 'T'),
        ('G', 'C'),
        ('G', 'C'),
        ('C', 'G'),
        ('G', 'C'),
        ('T', 'A'),
    ]
    Where either (or both) elements in the string might be missing:
    <-> T
    G <->
    G <-> C
    <->
    <-> C
    T <-> A
    Output:
    [
        ('', 'T'),
        ('G', ''),
        ('G', 'C'),
        ('', ''),
        ('', 'C'),
        ('T', 'A'),
    ]
    """
    pairTuples = []
    with open(dna_file, "r") as f:
        lines = f.readlines()
        for line in lines:
            baseLine = line.split("<->")
            pairTuples.append((baseLine[0].strip(), baseLine[1].strip()))
    return pairTuples
            

def is_rna(dna):
    """
    Given DNA in the aforementioned format,
    return the string "DNA" if the data is DNA,
    return the string "RNA" if the data is RNA,
    return the string "Invalid" if the data is neither DNA nor RNA.
    DNA consists of the following bases:
    Adenine  ('A'),
    Thymine  ('T'),
    Guanine  ('G'),
    Cytosine ('C'),
    RNA consists of the following bases:
    Adenine  ('A'),
    Uracil   ('U'),
    Guanine  ('G'),
    Cytosine ('C'),
    The data is DNA if at least 90% of the bases are one of the DNA bases.
    The data is RNA if at least 90% of the bases are one of the RNA bases.
    The data is invalid if more than 10% of the bases are not one of the DNA or RNA bases.
    Empty bases should be ignored.
    """
    dnaCount = 0
    rnaCount = 0
    totalBaseCount = 0
    DNA = ['A', 'T', 'G', 'C']
    RNA = ['A', 'U', 'G', 'C']
    for basePair in dna:
        for base in basePair:
            if base in DNA:
                dnaCount += 1
            if base in RNA:
                rnaCount += 1
            totalBaseCount += 1
    dna = dnaCount/totalBaseCount
    rna = rnaCount/totalBaseCount
    if dna >= 0.9:
        return "DNA"
    elif rna >= 0.9:
        return "RNA"
    else:
        return "Invalid"


def clean_dna(dna):
    """
    Given DNA in the aforementioned format,
    If the pair is incomplete, ('A', '') or ('', 'G'), ect
    Fill in the missing base with the match base.
    In DNA 'A' matches with 'T', 'G' matches with 'C'
    In RNA 'A' matches with 'U', 'G' matches with 'C'
    If a pair contains an invalid base the pair should be removed.
    Pairs of empty bases should be ignored.
    """
    isRNA = False
    completeDNA = []
    if is_rna(dna) == "RNA":
        isRNA = True
    else:
        isRNA = False

    for (base1, base2) in dna:
        if base1 == '' and base2 == '':
            continue
        if base1 == '':
            if base2 == 'C':
                base1 = 'G'
            elif base2 == 'G':
                base1 = 'C'
            elif base2 == 'T' or base2 == 'U':
                base1 = 'A'
            elif base2 == 'A':
                if isRNA:
                    base1 = 'U'
                else:
                    base1 = 'T'
            else:
                continue
        if base2 == '':
            if base1 == 'C':
                base2 = 'G'
            elif base1 == 'G':
                base2 = 'C'
            elif base1 == 'T' or base1 == 'U':
                base2 = 'A'
            elif base1 == 'A':
                if isRNA:
                    base2 = 'U'
                else:
                    base2 = 'T'
            else:
                continue
        completeDNA.append((base1, base2))
    return completeDNA

def mast_common_base(dna):
    """
    Given DNA in the aforementioned format,
    return the most common first base:
    eg. given:
    A <-> T
    G <-> C
    G <-> C
    C <-> G
    G <-> C
    T <-> A
    The most common first base is 'G'.
    Empty bases should be ignored.
    """
    firstBases = []
    firstBaseCounts = {}
    for (pair1, pair2) in dna:
        firstBases.append(pair1)
    firstBaseCounts['G'] = firstBases.count('G')
    firstBaseCounts['C'] = firstBases.count('C')
    firstBaseCounts['A'] = firstBases.count('A')
    firstBaseCounts['T'] = firstBases.count('T')
    firstBaseCounts['U'] = firstBases.count('U')
    sortedFirstBaseCounts = sorted(firstBaseCounts.items(), key=lambda x:x[1])
    return sortedFirstBaseCounts[-1][0]

def base_to_name(base):
    """
    Given a base, return the name of the base.
    The base names are:
    Adenine  ('A'),
    Thymine  ('T'),
    Guanine  ('G'),
    Cytosine ('C'),
    Uracil   ('U'),
    return the string "Unknown" if the base isn't one of the above.
    """
    if base == 'A':
        return "Adenine"
    elif base == 'T':
        return "Thymine"
    elif base == 'G':
        return "Guanine"
    elif base == 'C':
        return "Cytosine"
    elif base == 'U':
        return "Uracil"
