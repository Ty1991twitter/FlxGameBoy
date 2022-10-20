import haxe.io.UInt8Array;
import haxe.io.Bytes;
import sys.io.File;

using StringTools;

class Main
{
    public static function main()
    {
        GBA.romBytes = File.getBytes('roms/Tetris.gb');

        trace(getGameTitle());
        trace(getRomSize());

        trace(getOldLicensee());
        readEntryPoint();
    }

    static function readEntryPoint()
    {
        GBA.readOpCode(0x0100); // SHould be NOP
        GBA.readOpCode(0x0101); // Should be JP
    }

    static function getOldLicensee():String
    {
        var licenseee:Int = GBA.romBytes.get(0x014B);

        var licens = switch (licenseee)
        {
            case 0x00:
                "NONE";
            case 0x01:
                "NINTENDO";
            default:
                "OLD LICENSEE NOT IMPLEMENTED: " + licenseee.hex();
        }

        return licens;
    }


    static function getGameTitle():String
    {
        return GBA.romBytes.getString(0x0134, 15);
    }

  
    // gets in KByte
    static function getRomSize():Int
    {
        var sizeBit:Int = GBA.romBytes.get(0x0148); // returns value between $00 and $08 at this address

        sizeBit += 1;
        sizeBit *= 32;

        return sizeBit;
    }
}
