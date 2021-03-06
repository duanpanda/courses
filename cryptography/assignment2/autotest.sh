make test3
echo "---- Test MDES Encryption and Decryption ----"
java -ea:ryanduan.crypt.MDES Test_P1_3 < input1
java -ea:ryanduan.crypt.MDES Test_P1_3 < input2
java -ea:ryanduan.crypt.MDES Test_P1_3 < input3
java -ea:ryanduan.crypt.MDES Test_P1_3 < input4
java -ea:ryanduan.crypt.MDES Test_P1_3 < input5
java -ea:ryanduan.crypt.MDES Test_P1_3 < input_void
java -ea:ryanduan.crypt.MDES Test_P1_3 < input_invalid

echo "---- Test CBC Mode ----"
make testCBC
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CBC Test_P2_CBC < input1
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CBC Test_P2_CBC < input2
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CBC Test_P2_CBC < input3
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CBC Test_P2_CBC < input4
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CBC Test_P2_CBC < input5
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CBC Test_P2_CBC < input_void
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CBC Test_P2_CBC < input_invalid

echo "---- Test CTR Mode ----"
make testCTR
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR Test_P2_CTR < input1
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR Test_P2_CTR < input2
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR Test_P2_CTR < input3
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR Test_P2_CTR < input4
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR Test_P2_CTR < input5
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR Test_P2_CTR < input_void
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR Test_P2_CTR < input_invalid

echo "---- Test Hash ----"
make testhash
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.Hash TestHash < input1
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.Hash TestHash < input2
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.Hash TestHash < input3
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.Hash TestHash < input4
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.Hash TestHash < input5
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.Hash TestHash < input_void
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.Hash TestHash < input_invalid

echo "---- Test Birthday Attack ----"
make birthdayAttack
java -ea:ryanduan.crypt.MDES -ea:ryanduan.crypt.CTR -ea:ryanduan.crypt.Hash BirthdayAttack < input1
