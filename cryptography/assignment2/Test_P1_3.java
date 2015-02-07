import java.io.*;
import java.util.Arrays;
import ryanduan.crypt.MDES;

class Test_P1_3 {
    public static void main(String[] args) {
        // read characters from standard input
        char[] charBuffer = new char[1024];
        int len = 0;
        try {
            len = readInput(charBuffer);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("len=" + len);
        System.out.println(new String(charBuffer, 0, len));

        // Convert chars to bit string (using int array to simulate it) one
        // char is converted to 5 bits.
        //
        // Bit buffer length should be multiple of 16, and must contain all the
        // code for all the characters.
        int bitBufLen = ((int)Math.ceil(len * 5 / 16)) * 16;
        int[] bitStr = new int[bitBufLen];

        // padding with 0 in the end of the bit string
        Arrays.fill(bitStr, 0);

        // turn char string into binary code
        MDES.txtToCode(charBuffer, len, bitStr);
        MDES.printBitString(bitStr);
        int[] encoded = MDES.encode(bitStr, new int[][] {
                {1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0},
                {1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1}
            });
        MDES.printBitString(encoded);
        char[] encodedTxt = new char[len];
        MDES.codeToTxt(encoded, encodedTxt);
        System.out.println(new String(encodedTxt));
    }

    // populate input chars from standard input into charBuffer, and return the
    // length of the input string that has been read
    public static int readInput(char[] charBuffer) throws IOException {
        int i = 0;
        int ch;

        // -1 indicates End-Of-File
        //
        // Caution:
        // If we use a char to receive System.in.read() then we will NOT get -1
        // when it encounters End-Of-File.
        while (i < charBuffer.length && (ch = System.in.read()) != -1) {
            charBuffer[i++] = (char)ch;
        }
        return i;
    }
}
