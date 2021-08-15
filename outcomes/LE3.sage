load("__common__.sage")

def generator():
    # single solution
    # create a 3x3 invertible matrix
    A = simple_random_matrix_of_rank(3,rows=3,columns=3)
    solution = column_matrix(
        vector(QQ, [randrange(1,4)*choice([-1,1]) for _ in range(3)])
    )
    constants = A*solution
    matrix = A.augment(constants, subdivide=True)
    if choice([True,False]):
        system = latex_system_from_matrix(matrix)
    else:
        system = vectorEquation(matrix)
    systems = [{
        "count": "one solution",
        "system": system,
        "matrix": matrix,
        "rref": matrix.rref(),
        "solset": "\\left\\{"+latex(solution)+"\\right\\}",
    }]

    # infinitely-many solutions
    # create a 3x3 non-invertible matrix
    A = simple_random_matrix_of_rank(2,rows=3,columns=3)
    image_basis = [A.column(p) for p in A.pivots()]
    coeffs = [
        randrange(1,4)*choice([-1,1])
        for _ in range(2)
    ]
    lin_combo = column_matrix(sum([
        coeffs[p]*image_basis[p]
        for p in range(2)
    ]))
    matrix = A.augment(lin_combo, subdivide=True)
    if choice([True,False]):
        system = latex_system_from_matrix(matrix)
    else:
        system = vectorEquation(matrix)
    systems += [{
        "count": "infinitely-many solutions",
        "system": system,
        "matrix": matrix,
        "rref": matrix.rref(),
    }]

    # no solutions
    # create a 4x4 non-invertible matrix
    A = simple_random_matrix_of_rank(2,rows=3,columns=3)
    image_basis = [A.column(p) for p in A.pivots()]
    coeffs = [
        randrange(1,4)*choice([-1,1])
        for _ in range(2)
    ]
    lin_combo = sum([
        coeffs[p]*image_basis[p]
        for p in range(2)
    ])
    non_lin_combo = lin_combo + vector(QQ, [
        choice([-1,1])
        for _ in range(3)
    ])
    while non_lin_combo in A.column_space():
        non_lin_combo += vector(QQ, [
            choice([-1,1])
            for _ in range(3)
        ])
    matrix = A.augment(column_matrix(non_lin_combo), subdivide=True)
    if choice([True,False]):
        system = latex_system_from_matrix(matrix)
    else:
        system = vectorEquation(matrix)
    systems += [{
        "count": "no solutions",
        "system": system,
        "matrix": matrix,
        "rref": matrix.rref(),
        "solset": "\\emptyset"
    }]

    shuffle(systems)
    
    return {
        "systems": systems,
    }
