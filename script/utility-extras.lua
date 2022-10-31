G_TechsIcEffValues = {}
G_TechsResEffValues = {}

ReadTechsIcEffValues()
-- Utils.INSPECT_TABLE(G_TechsIcEffValues)

ReadTechsResEffValues()
-- Utils.INSPECT_TABLE(G_TechsResEffValues)


--- Minister tech decay doesn't work because a "+=" is actually a "=" in the source. This fixes it.
function PatchMinisterTechDecay()
    --print(ReadHex("hoi3_tfh.exe", 0xDD7EC, 10))
    WriteHex("hoi3_tfh.exe", 0xDD7ED, "0x01")
    --print(ReadHex("hoi3_tfh.exe", 0xDD7EC, 10))
end

--- When a country switches from war to peace all the War Exhaustion gets added to neutrality
--- WE is not used in events, instead its mirrored as a country variable.
--- To keep the minister tooltip they need to use it, so to avoid neutrality gain we disable that part with these bytes
function PatchMinisterWarExhaustionNeutralityReset()
    local hex = "0x3BC37E1153518BCC8919E868F3010090909090909083BF6801"
    --print(ReadHex("hoi3_tfh.exe", 0xDC009, 25))
    WriteHex("hoi3_tfh.exe", 0xDC009, hex)
    --print(ReadHex("hoi3_tfh.exe", 0xDC009, 25))
end

function PatchLargeAddressAware()
    WriteHex("hoi3_tfh.exe", 0x138, "0x9165E5")
    WriteHex("hoi3_tfh.exe", 0x146, "0x22")
    WriteHex("hoi3_tfh.exe", 0x188, "0x67B1")
    WriteHex("hoi3_tfh.exe", 0x1180524, "0x9165E5")
    WriteHex("hoi3_tfh.exe", 0x11FB60D, "0x313A35363A3436")
    WriteHex("hoi3_tfh.exe", 0x11FB618, "0x4A616E202033")
    WriteHex("hoi3_tfh.exe", 0x11FB622, "0x33")
    WriteHex("hoi3_tfh.exe", 0x120D77C, "0x6E68DAD73DE05F4394C72CD557D09411")
    WriteHex("hoi3_tfh.exe", 0x12F34B4, "0x4C64E5")
end
