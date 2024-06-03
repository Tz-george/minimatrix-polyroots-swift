import Foundation

let EPS: Double = pow(2, -52)

struct Root {
    var real: Double
    var imag: Double
}

func swap(_ a: inout Double, _ b: inout Double) {
    let tmp = a
    a = b
    b = tmp
}

func nearestInt(_ n: Double) -> Double {
    let l = floor(n), h = ceil(n)
    let dl = abs(n - l)
    let dh = abs(n - h)
    return dl > dh ? dh : dl
}

func evaluate(x: Double, A: Double, B: Double, C: Double, D: Double) -> (Q: Double, dQ: Double, b: Double, c: Double) {
    let q0 = A * x,
        b = q0 + B,
        c = b * x + C
    return (
        Q: c * x + D,
        dQ: (q0 + b) * x + c,
        b: b,
        c: c
    )
}

func getDistinctRoots(roots: [Root], TOL: Double=1e-14) -> [Root] {
    var uniqueRoots: [Root] = []
    roots.forEach { root in
        let isNotUnique = uniqueRoots.reduce(false) { partialResult, curRoot in
            partialResult || (abs(curRoot.real - root.real) < TOL && abs(curRoot.imag - root.imag) < TOL)
        }
        if !isNotUnique {
            uniqueRoots.append(root)
        }
    }
    return uniqueRoots
}

// Calculates the discriminant of Ax^2 + Bx + C = 0
func disc(_ A: Double, _ B: Double, _ C: Double) -> Double {
    var a = A, b = B, c = C
    let isIntCoeffs = abs(floor(A) - A) == 0 && abs(floor(B) - B) == 0 && abs(floor(C) - C) == 0
    
    if isIntCoeffs {
        if a * c > 0 {
            a = abs(A)
            c = abs(c)
        }
        var loopCondition = true
        while loopCondition {
            loopCondition = false
            if a < c {
                swap(&a, &c)
            }
            let n = nearestInt(b/c)
            if n != 0 {
                let alpha = a - n * b
                if alpha >= -a {
                    b = b - n * c
                    a = alpha - n * b
                    if a > 0 {
                        loopCondition = true
                    }
                }
            }
        }
    }
    return b * b - a * c
}


// Computes the roots of the quadratic Ax^2 + Bx + C = 0
func qdrtc(_ A: Double, _ B: Double, _ C: Double) -> [Root] {
    let b = -B / 2, q = disc(A, b, C)
    var X1 = 0.0, Y1 = 0.0, X2 = 0.0, Y2 = 0.0
    
    if q < 0 {
        let X = b / A, Y = sqrt(-q) / A
        X1 = X
        Y1 = Y
        X2 = X
        Y2 = -Y
    } else {
        Y1 = 0
        Y2 = 0
        let r = b + b.sign.val * sqrt(q)
        if r == 0 {
            X1 = C / A
            X2 = -C / A
        } else {
            X1 = C / r
            X2 = r / A
        }
    }
    return [
        Root(real: X1, imag: Y1),
        Root(real: X2, imag: Y2),
    ]
}

// Solves the linear equation Ax + B = 0 for x
func getLinearRoot(A: Double, B: Double) -> Root? {
    if A != 0 {
        return Root(real: -B / A, imag: 0)
    } else {
        return nil
    }
}

// Solves the linear equation Ax^2 + Bx + C = 0 for X
func getQuadraticRoots(_ A: Double, _ B: Double, _ C: Double) -> [Root] {
    return qdrtc(A, B, C)
}

func getCubicRoots(A: Double, B: Double, C: Double, D: Double) -> [Root] {
    if A == 0 {
        // when A == 0, use getQuadraticRoots
        return getQuadraticRoots(B, C, D)
    } else if D == 0 {
        var roots: [Root] = [Root(real: 0, imag: 0)]
        let quadInfo = qdrtc(A, B, C)
        roots.append(contentsOf: quadInfo)
        return roots
    } else {
        var X = -(B / A) / 3, a = A
        var evalInfo = evaluate(x: X, A: A, B: B, C: C, D: D)
        var q = evalInfo.Q, dq = evalInfo.dQ
        var b = evalInfo.b, c = evalInfo.c
        
        var t = q / A, r = pow(abs(t), 1 / 3), s = t.sign.val
        t = -dq / A
        if t > 0 {
            r = 1.324717957244746 * max(r, sqrt(t))
        }
        var x0 = X - s * r
        if x0 != X {
            let den: Double = 1.0 + (100.0 * EPS)
            
            // simulate do-while
            let calculate = {
                X = x0
                evalInfo = evaluate(x: X, A: A, B: B, C: C, D: D)
                q = evalInfo.Q
                dq = evalInfo.dQ
                b = evalInfo.b
                c = evalInfo.c
                x0 = dq == 0 ? X : X - (q / dq) / den
            }
            
            calculate()
            while s * x0 > s * X {
                calculate()
            }
            
            if abs(A) * X * X > abs(D / X) {
                c = -D / X
                b = (c - C) / X
            }
        }
        var roots: [Root] = [Root(real: X, imag: 0)]
        let quadInfo = qdrtc(a, b, c)
        roots.append(contentsOf: quadInfo)
        return roots
    }
}

// solves the linear equation Ax^4 + Bx^3 + Cx^2 + Dx + E = 0 for x
func getQuarticRoots(A: Double, B: Double, C: Double, D: Double, E: Double) -> [Root] {
    // See link for method:
    // https://math.stackexchange.com/questions/785/is-there-a-general-formula-for-solving-4th-degree-equations-quartic
    if A == 0 {
        return getCubicRoots(A: B, B: C, C: D, D: E)
    }
    
    // compute the "depressed" quartic via the substitution x = z - (b/4a)
    // az^4 + bz^2 + cz + d = 0
    // B, C, D are reals
    let b = C - (3 * B * B) / (8 * A),
        c = D - (B * C) / (2 * A) + (B * B * B) / (8 * A * A),
        d = E - (B * D) / (4 * A) + (B * B * C) / (16 * A * A) - (3 * B * B * B * B) / (256 * A * A * A)
    // compute the "depressed" monic quatic:
    // z^4 + pz^2 + qz + r = 0
    // p, q, r are reals
    let p = b / A,
        q = c / A,
        r = d / A
    // Since p, q, r are reals, Descartes Factorization:
    // (z^2+mz+n)(z^2+sz+t) = 0
    // m, n, s, t are reals
    // solving for constants yields:
    // (z^2+mz+n)(z^2 - mz+(r/n)) = 0
    // we also get:
    // m^6 + 2pm^4 + (p^2 - 4r)m^2 - q^2 = 0
    // Substitute w = m^2
    // w^3 + 2pw^2 + (p^2 - 4r)w + q^2 = 0
    // if m is real, then w must be real and w >= 0.
    // for t to be real, then w > 0.
    let ws = getCubicRoots(A: 1, B: 2 * p, C: p * p - 4 * r, D: -q * q)
        .filter({ $0.imag == 0})
        .map({ $0.real })
        .filter({ $0 > 0 })
    
    let zCoeffes = ws.reduce(into: [(m: Double, n: Double)]()) { partialResult, w in
        let m0 = sqrt(w),
            m1 = -m0,
            n = 0.5 * (p + w),
            n0 = n - q / (2 * m0),
            n1 = n - q / (2 * m1)
        partialResult.append((m: m0, n: n0))
        partialResult.append((m: m1, n: n1))
    }
    
    let zs = zCoeffes.reduce(into: [Root]()) { partialResult, z in
        let m = z.m, n = z.n
        let quadInfo1 = getQuadraticRoots(1, m, n),
            quadInfo2 = getQuadraticRoots(1, -m, r/n)
        partialResult.append(contentsOf: quadInfo1)
        partialResult.append(contentsOf: quadInfo2)
    }
    let uniqueZ = getDistinctRoots(roots: zs)
    return uniqueZ.map({ Root(real: $0.real + -B / (4 * A), imag: $0.imag) })
}

extension FloatingPointSign {
    var val: Double {
        switch self {
        case .plus: return 1
        case .minus: return -1
        }
    }
}
