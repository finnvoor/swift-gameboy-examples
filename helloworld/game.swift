@main struct Game {
    static func main() {
        let io = UnsafeMutableRawBufferPointer(
            start: UnsafeMutableRawPointer(bitPattern: 0x4000000),
            count: 0x3fe
        )

        let vram = UnsafeMutableBufferPointer<UInt16>(
            start: UnsafeMutablePointer<UInt16>(bitPattern: 0x6000000),
            count: 0xc000
        )

        // Set bitmap video mode and enable background rendering
        io.baseAddress!.storeBytes(
            of: 0b10000000011,
            as: UInt32.self
        )

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

@_cdecl("__atomic_compare_exchange_4")
func __atomic_compare_exchange_4() {}
@_cdecl("__atomic_fetch_add_4")
func __atomic_fetch_add_4(ptr: UnsafeMutableRawPointer, val: Int32, memorder: Int32) -> Int32 { 0 }
@_cdecl("__atomic_fetch_sub_4")
func __atomic_fetch_sub_4(ptr: UnsafeMutableRawPointer, val: Int32, memorder: Int32) -> Int32 { 0 }
@_cdecl("__atomic_load_4")
func __atomic_load_4(ptr: UnsafeRawPointer, memorder: Int32) -> Int32 { 0 }
@_cdecl("__atomic_store_4")
func __atomic_store_4(ptr: UnsafeMutableRawPointer, val: Int32, memorder: Int32) {}
