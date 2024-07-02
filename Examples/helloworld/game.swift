import _Volatile

@main struct Game {
    static func main() {
        let io = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x4000000)

        let vram = UnsafeMutableBufferPointer<UInt16>(
            start: UnsafeMutablePointer<UInt16>(bitPattern: 0x6000000),
            count: 0xc000
        )

        // Set bitmap video mode and enable background rendering
        io.store(0b10000000011)

        // Draw a gradient
        for x in 0..<240 {
            for y in 0..<160 {
                let red = UInt16(x * 31 / 239)
                let blue = UInt16(y * 31 / 159)
                let color = red | (blue << 10)
                vram[x + y * 240] = color
            }
        }

        while true {}
    }
}

@_cdecl("__atomic_load_4")
func atomicLoad4(
    _ ptr: UnsafePointer<UInt32>,
    _ ordering: UInt32
) -> UInt32 {
    ptr.pointee
}

@_cdecl("__atomic_store_4")
func atomicStore4(
    _ ptr: UnsafeMutablePointer<UInt32>,
    _ value: UInt32,
    _ ordering: UInt32
) {
    ptr.pointee = value
}

@_cdecl("__atomic_store_2")
func atomicStore2(
    _ ptr: UnsafeMutablePointer<UInt16>,
    _ value: UInt16,
    _ ordering: UInt32
) {
    ptr.pointee = value
}

@_cdecl("__atomic_fetch_add_4")
func atomicFetchAdd4(
    _ ptr: UnsafeMutablePointer<UInt32>,
    _ value: UInt32,
    _ ordering: UInt32
) -> UInt32 {
    let tmp = ptr.pointee
    ptr.pointee += value
    return tmp
}

@_cdecl("__atomic_fetch_sub_4")
func atomicFetchSub4(
    _ ptr: UnsafeMutablePointer<UInt32>,
    _ value: UInt32,
    _ ordering: UInt32
) -> UInt32 {
    let tmp = ptr.pointee
    ptr.pointee -= value
    return tmp
}

@_cdecl("__atomic_compare_exchange_4")
func atomicCompareExchange4(
    _ ptr: UnsafeMutablePointer<UInt32>,
    _ expected: UnsafeMutablePointer<UInt32>,
    _ desired: UInt32,
    _ isWeak: Bool,
    _ successOrdering: UInt32,
    _ failureOrdering: UInt32
) -> Bool {
    if ptr.pointee == expected.pointee {
        ptr.pointee = desired
        return true
    } else {
        expected.pointee = ptr.pointee
        return false
    }
}
