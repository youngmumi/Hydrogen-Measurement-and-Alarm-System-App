const int greenLED = 13;  // LED를 연결한 핀 번호
const int redLED = 12;   // LED를 연결한 핀 번호

// 메인 함수
void setup() {
  // 시리얼 통신 초기화
  Serial.begin(9600);

  // LED 초기화
  pinMode(greenLED, OUTPUT);
  pinMode(redLED, OUTPUT);
}

void loop() {
  // 바코드 읽기
  String barcode = Serial.readStringUntil('\n');

  // 바코드 비교
  if (barcode.equals("")) {
    // 바코드가 입력되지 않았을 경우
    Serial.println("바코드를 입력하세요.");
  } else if (barcode.equals("exit")) {
    // exit를 입력하면 종료
    Serial.println("프로그램 종료");
  } else {
    // 바코드가 입력되었을 경우
    if (barcode.equals("1234567890")) {
      // 옳은 코드일 경우
      Serial.println("통과");
      digitalWrite(greenLED, HIGH);
      delay(500);
      digitalWrite(greenLED, LOW);
    } else {
      // 옳지 않은 코드일 경우
      // 임의의 수를 입력했을 경우
      Serial.println("입력하신 값은 바코드가 아닙니다.");
      digitalWrite(redLED, HIGH);
      delay(500);
      digitalWrite(redLED, LOW);
    }
  }
}
